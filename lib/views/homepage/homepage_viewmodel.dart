import 'package:shop_app/app/locator.dart';
import 'package:shop_app/core/models/user_profile.dart';
import 'package:shop_app/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/sales_record.dart';

class HomepageViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();

  List<Sales>? get allSales => _authService.recordSale?.sales;
  List<Stocks>? get allStocks => _authService.recordSale?.stocks;

  Profile? get profile => _authService.profile;

  void setUp() {}

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
