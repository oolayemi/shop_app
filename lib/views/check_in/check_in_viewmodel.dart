import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app/app/locator.dart';
import 'package:shop_app/core/models/api_response.dart';
import 'package:shop_app/core/models/check_in_data.dart';
import 'package:shop_app/core/models/nearby_store.dart';
import 'package:shop_app/core/services/auth_service.dart';
import 'package:shop_app/views/check_in_form/check_in_form_viewmodel.dart';
import 'package:shop_app/views/homepage/homepage_view.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/exceptions/error_handling.dart';
import '../../core/utils/tools.dart';
import '../check_in_form/check_in_form_view.dart';

class CheckInViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  Future gotoCheckInForm(context) async {
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

    final response = await checkIfCheckedIn();
    if (response.showMessage == true) {
      _navigationService.clearStackAndShowView(const HomepageView());
      flusher(response.message, context, color: Colors.red);
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _navigationService.navigateToView(const CheckInFormView());
  }

  Future<ApiResponse> checkIfCheckedIn() async {
    ApiResponse apiResponse = ApiResponse(showMessage: false);
    try {
      var response = await dio().get('/user/check-in/verify');

      Map responseData = response.data!;

      Map jsonData = jsonDecode(response.toString());
      print(jsonEncode(responseData));
      if (responseData['status'] == 'success') {
        apiResponse = ApiResponse(showMessage: false);
        return apiResponse;
      } else {
        CheckInData checkInData = CheckInData.fromJson(jsonData['data']);
        await _authService.setCheckedIn(checkInData);
        await _authService.getProfile();
        CheckInFormViewModel().getStoreProducts(checkInData.storeId!);
        apiResponse = ApiResponse(showMessage: true, message: json.decode(response.toString())['message']);
        return apiResponse;
      }
    } on DioError catch (e) {
      print(e.response);
      apiResponse = ApiResponse(showMessage: true, message: 'Request error: ${DioExceptions.fromDioError(e).toString()}');
      return apiResponse;
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
