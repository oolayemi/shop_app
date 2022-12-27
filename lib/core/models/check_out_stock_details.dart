import 'store_products_response.dart';

class CheckOutDetailsResponse {
  String? status;
  String? message;
  List<CheckOutDetails>? data;

  CheckOutDetailsResponse({this.status, this.message, this.data});

  CheckOutDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CheckOutDetails>[];
      json['data'].forEach((v) {
        data!.add(CheckOutDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckOutDetails {
  int? id;
  int? checkInId;
  int? checkInQuantity;
  int? productId;
  int? soldQuantity;
  int? checkoutQuantity;
  Product? product;

  CheckOutDetails(
      {this.id,
        this.checkInId,
        this.checkInQuantity,
        this.productId,
        this.soldQuantity,
        this.checkoutQuantity,
        this.product});

  CheckOutDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkInId = json['check_in_id'];
    checkInQuantity = json['check_in_quantity'];
    productId = json['product_id'];
    soldQuantity = json['sold_quantity'];
    checkoutQuantity = json['checkout_quantity'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['check_in_id'] = checkInId;
    data['check_in_quantity'] = checkInQuantity;
    data['product_id'] = productId;
    data['sold_quantity'] = soldQuantity;
    data['checkout_quantity'] = checkoutQuantity;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}