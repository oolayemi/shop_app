import 'package:shop_app/core/models/store_products_response.dart';

class AddInput {
  final Product? product;
  final int? quantity;

  AddInput({this.product, this.quantity});

  Map<String, dynamic> toMap(Product product, int quantity) {
    return {
      'product': product,
      'quantity': quantity,
    };
  }

  AddInput.fromJson(Map<String, dynamic> json)
      : product = json['product'],
        quantity = json['quantity'];
}