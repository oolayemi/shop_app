import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/models/check_in_data.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/add_input.dart';
import '../../core/models/store_products_response.dart';
import '../../core/services/auth_service.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../homepage/homepage_view.dart';
import '../success_screen.dart';

class RecordSaleViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> records = [];

  int inputIndex = 0;
  double totalAmount = 0;

  CheckInData? get checkInData => _authService.checkedIn;

  List<StoreProductData>? get storeProducts => _authService.storeProduct;

  Product? selectedProduct;
  TextEditingController quantityController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  addProduct(context) {
    records.add(AddInput().toMap(selectedProduct!, int.parse(quantityController.text)));
    selectedProduct = null;
    quantityController.clear();
    FocusScope.of(context).unfocus();
    notifyListeners();
    getTotal();
  }

  removeProduct(context, e) {
    records.remove(e);
    inputIndex = 1;
    notifyListeners();
    FocusScope.of(context).unfocus();
    getTotal();
  }

  getTotal() {
    totalAmount = 0;
    for (var element in records) {
      totalAmount += double.parse(element['product'].price) * element['quantity'];
    }
    notifyListeners();
  }

  Future<void> recordSale(context) async {
    List newRecords = [];
    LoaderDialog.showLoadingDialog(context, message: "Recording sale...");
    for (var element in records) {
      newRecords.add({'product_id': element['product'].id, 'quantity': element['quantity']});
    }
    try {
      var data = {'check_in_id': checkInData!.id, 'products': newRecords};

      var response = await dio().post('/user/sale/add', data: data);

      int? statusCode = response.statusCode;
      Map responseData = response.data!;

      if (statusCode == 200) {
        if (responseData['status'] == 'success') {
          _authService.getSales();
          _navigationService.back();
          _navigationService.navigateToView(
            SuccessfulScreen(
              title: "New Sale Recorded\nSuccessfully",
              buttonTitle: "Go Home",
              onPressed: () => NavigationService().clearStackAndShowView(const HomepageView()),
            ),
          );
        } else {
          _dialogService.completeDialog(DialogResponse());
          flusher(json.decode(response.toString())['message'], context, color: Colors.red);
        }
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

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

  setup() {
    _authService.getProfile();
  }
}
