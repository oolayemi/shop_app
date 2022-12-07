import 'package:shop_app/app/locator.dart';
import 'package:shop_app/views/set_password/set_password_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

  gotoSetPassword() {
    _navigationService.navigateToView(const SetPasswordView());
  }

}