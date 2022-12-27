import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/models/api_response.dart';
import 'package:shop_app/core/models/check_out_stock_details.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/check_in_data.dart';
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

  TextEditingController commentController = TextEditingController();

  List<CheckOutDetails> checkOutDetails = [];
  List<Map<String, dynamic>> recordValues = [];

  CheckInData? get checkInData => _authService.checkedIn;

  void setQuantity(CheckOutDetails checkOutDetails, int value, int index) {
    var detailsValue = {'check_in_stock_id': checkOutDetails.id, 'quantity': value};

    if (recordValues.asMap().containsKey(index)) {
      recordValues[index] = detailsValue;
    } else {
      recordValues.insert(index, detailsValue);
    }

    print(recordValues);
  }

  Future<void> checkOut(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Checking out...");
    try {
      var data = {'check_in_id': checkInData!.id, 'comment': commentController.text, 'check_outs': recordValues};

      var response = await dio().post("/user/check-out", data: data);

      int? statusCode = response.statusCode;
      Map responseData = response.data!;

      if (statusCode == 200) {
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

  Future<ApiResponse> fetchCheckInStock(context) async {
    ApiResponse response = ApiResponse(showMessage: false);
    try {
      await dio().get("/user/check-in/stocks/${checkInData!.id}").then((value) async {
        print("GET SALES RESPONSE::::");

        int? statusCode = value.statusCode;
        Map<String, dynamic> responseData = value.data!;

        if (statusCode == 200) {
          if (responseData['status'] == 'success') {
            print(jsonEncode(responseData));
            CheckOutDetailsResponse checkOutDetailsResponse = CheckOutDetailsResponse.fromJson(responseData);
            checkOutDetails = checkOutDetailsResponse.data!;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(showMessage: true, message: responseData['message']);
            return;
          }
        } else {
          response = ApiResponse(showMessage: true, message: responseData['message']);
        }
      });
    } on DioError catch (e) {
      print(e.response!);
      response = ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

  Future<void> setUp(context) async {
    await fetchCheckInStock(context);
  }
}
