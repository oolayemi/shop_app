import 'package:shop_app/app/locator.dart';
import 'package:shop_app/views/check_in/check_in_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SetPasswordViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

  gotoCheckOut() {
    _navigationService.clearStackAndShowView(const CheckInView());
  }

}