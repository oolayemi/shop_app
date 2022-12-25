import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/add_input.dart';
import '../../core/models/check_in_data.dart';
import '../../core/models/store_products_response.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/utility_storage_service.dart';
import '../../core/utils/tools.dart';
import '../check_in/check_in_view.dart';
import '../success_screen.dart';

class CheckOutFormViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final StorageService _storageService = locator<StorageService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> records = [];

  Product? selectedProduct;
  TextEditingController quantityController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<StoreProductData>? get storeProducts => _authService.storeProduct;

  CheckInData? get checkInData => _authService.checkedIn;

  int inputIndex = 0;

  addProduct(context) {
    records.add(AddInput().toMap(selectedProduct!, int.parse(quantityController.text)));
    selectedProduct = null;
    quantityController.clear();
    FocusScope.of(context).unfocus();
    notifyListeners();
    print(records);
  }

  Future<void> checkOut(context) async {
    List newRecords = [];
    LoaderDialog.showLoadingDialog(context, message: "Checking out...");
    for (var element in records) {
      newRecords.add({'product_id': element['product'].id, 'quantity': element['quantity']});
    }
    try {
      var data = {'check_in_id': checkInData!.id, 'comment': commentController.text, 'products': newRecords};

      var response = await dio().post("/user/check-out", data: data);

      int? statusCode = response.statusCode;
      Map responseData = response.data!;

      if (statusCode == 200) {
        Map jsonData = jsonDecode(response.toString());
        if (responseData['status'] == 'success') {
          _storageService.addBool('isCheckedIn', false);
          _navigationService.clearStackAndShowView(
            SuccessfulScreen(
              title: "CheckOut Successful",
              buttonTitle: "Go to Check In",
              onPressed: () => NavigationService().clearStackAndShowView(const CheckInView()),
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

  setUp(context) {

  }
}
