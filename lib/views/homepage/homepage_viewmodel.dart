import 'package:shop_app/app/locator.dart';
import 'package:shop_app/core/models/user_profile.dart';
import 'package:shop_app/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/sales_record.dart';

class HomepageViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();

  List<Sale>? get allSales => _authService.recordSale;
  Profile? get profile => _authService.profile;

  void setUp() {}

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
