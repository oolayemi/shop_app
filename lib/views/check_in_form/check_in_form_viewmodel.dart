import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/locator.dart';
import 'package:shop_app/core/models/add_input.dart';
import 'package:shop_app/core/models/store_products_response.dart';
import 'package:shop_app/core/services/auth_service.dart';
import 'package:shop_app/core/services/utility_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/check_in_data.dart';
import '../../core/models/nearby_store.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../homepage/homepage_view.dart';
import '../success_screen.dart';

class CheckInFormViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final StorageService _storageService = locator<StorageService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> records = [];

  List<Store>? get stores => _authService.listStores;
  Store? selectedStore;

  StoreProductData? selectedProduct;
  TextEditingController quantityController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  int inputIndex = 0;
  int storeProductsCount = 0;

  List<StoreProductData> storeProducts = [];
  List<StoreProductData> removedProducts = [];

  Future<void> setUp(context) async {
    if (stores!.isEmpty) {
      await _authService.getStores();
    }
    if (stores!.isEmpty) {
      for (Store item in stores!) {
        await getStoreProducts(item.id!);
      }
    }
    //if (!errorFetching && fetched) {
    selectStore(stores![0]);
    //}
    notifyListeners();
  }

  Future<void> selectStore(Store item) async {
    selectedStore = item;
    await getStoreProducts(item.id!);
    selectedProduct = null;
    quantityController.clear();
    commentController.clear();
    records.clear();
    notifyListeners();
  }

  addProduct(context) {
    records.add(AddInput().toMap(selectedProduct!.product!, int.parse(quantityController.text)));
    removedProducts.add(selectedProduct!);
    storeProducts.removeWhere((element) => element.productId == selectedProduct!.productId);
    selectedProduct = null;
    quantityController.clear();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  removeProduct(context, e) {
    storeProducts.add(removedProducts.where((element) => element.product!.id == e['product'].id).single);
    removedProducts.removeWhere((element) => element.product!.id == e['product'].id);
    records.remove(e);
    inputIndex = 1;
    notifyListeners();
    FocusScope.of(context).unfocus();
  }

  Future getStoreProducts(int id) async {
    try {
      await dio().get('/user/stores/products/get/$id').then((value) async {
        var seen = <String>{};
        print("GET STORES PRODUCTS RESPONSE::::");
        Map<String, dynamic> responseData = value.data!;
        if (responseData['status'] == 'success') {
          StoreProductResponse storeProductResponse = StoreProductResponse.fromJson(responseData);
          storeProducts = storeProductResponse.data!.where((storeProduct) => seen.add(storeProduct.productId.toString())).toList();
          storeProductsCount = storeProducts.length;
          removedProducts.clear();
          _authService.setCurrentStoreProducts(storeProducts);
          notifyListeners();
        } else {}
      });
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> checkIn(context) async {
    if (records.length < storeProductsCount) {
      flusher("Please fill in each product's quantity", context, color: Colors.red);
    } else {
      List newRecords = [];
      LoaderDialog.showLoadingDialog(context, message: "Checking in...");
      for (var element in records) {
        newRecords.add({'product_id': element['product'].id, 'quantity': element['quantity']});
      }
      try {
        var data = {'store_id': selectedStore!.id, 'comment': commentController.text, 'products': newRecords};

        var response = await dio().post('/user/check-in', data: data);

        Map responseData = response.data!;

        Map jsonData = jsonDecode(response.toString());
        if (responseData['status'] == 'success') {
          _storageService.addBool('isCheckedIn', true);
          CheckInData checkInData = CheckInData.fromJson(jsonData['data']);
          _authService.setCheckedIn(checkInData);
          await getStoreProducts(checkInData.storeId!);
          await _authService.getProfile();
          await _authService.getSales();
          _navigationService.clearStackAndShowView(
            SuccessfulScreen(
              title: "CheckIn Successful",
              buttonTitle: "Go Home",
              onPressed: () => NavigationService().clearStackAndShowView(const HomepageView()),
            ),
          );
        } else {
          _dialogService.completeDialog(DialogResponse());
          flusher(json.decode(response.toString())['message'], context, color: Colors.red);
        }
      } on DioError catch (e) {
        _dialogService.completeDialog(DialogResponse());
        print(e.response);
        flusher('Request error: ${DioExceptions.fromDioError(e).toString()}', context, color: Colors.red);
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
