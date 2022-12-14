import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/locator.dart';
import 'package:shop_app/core/services/auth_service.dart';
import 'package:shop_app/core/services/utility_storage_service.dart';
import 'package:shop_app/views/sign_up/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../check_in/check_in_view.dart';

class SignInViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final StorageService _storageService = locator<StorageService>();
  final DialogService _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

  gotoSignUp() {
    _navigationService.navigateToView(const SignUpView());
  }

  Future<void> signIn(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Signing in...");
    try {
      var data = {'email': emailController.text, 'password': passwordController.text};

      var response = await dio(withToken: false).post('/auth/login', data: data);

      Map responseData = response.data!;

        Map jsonData = jsonDecode(response.toString());
        if (responseData['status'] == 'success') {
          _storageService.addString("token", jsonData['token']);
          _storageService.addString('email', emailController.text);
          _storageService.addBool('isLoggedIn', true);
          await _authService.getStores();
          _navigationService.clearStackAndShowView(const CheckInView());
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
