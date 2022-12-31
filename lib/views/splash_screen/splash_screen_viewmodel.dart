import 'package:shop_app/app/locator.dart';
import 'package:shop_app/core/services/utility_storage_service.dart';
import 'package:shop_app/views/check_in/check_in_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../sign_in/signin_view.dart';

class SplashScreenViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  void setup() {
    Future.delayed(const Duration(seconds: 4), () {
      if(_storageService.getString("token") != null &&  _storageService.getBool('isLoggedIn') != null &&  _storageService.getBool('isLoggedIn') != false) {
        _navigationService.clearStackAndShowView(const CheckInView());
      }else {
        _navigationService.clearStackAndShowView(const SignInView());
      }

    });
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
