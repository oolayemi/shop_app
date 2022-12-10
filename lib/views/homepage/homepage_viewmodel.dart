import 'package:stacked/stacked.dart';

class HomepageViewModel extends ReactiveViewModel {
  bool toggleProducts = false;

  void toggleProduct() {
    toggleProducts = !toggleProducts;
    notifyListeners();
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}