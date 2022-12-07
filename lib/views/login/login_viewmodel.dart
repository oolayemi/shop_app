import 'package:shop_app/app/locator.dart';
import 'package:shop_app/views/sign_up/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

  gotoSignUp() {
    _navigationService.navigateToView(const SignUpView());
  }

}