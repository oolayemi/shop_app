import 'package:flutter/material.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

class CheckOutFormViewModel extends ReactiveViewModel {
  final formKey = GlobalKey<FormState>();
  List<Widget> records = [];

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

  setUp(context) {
    records.add(const SomethingSha());
  }
}
