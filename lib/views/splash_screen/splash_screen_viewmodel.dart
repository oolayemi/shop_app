import 'package:shop_app/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../sign_in/signin_view.dart';

class SplashScreenViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void setup() {
    Future.delayed(const Duration(seconds: 4), () {
      _navigationService.clearStackAndShowView(const SignInView());
    });
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
