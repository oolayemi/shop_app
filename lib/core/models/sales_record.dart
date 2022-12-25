import 'store_products_response.dart';

class SalesRecord {
  String? status;
  String? message;
  List<Sale>? data;

  SalesRecord({this.status, this.message, this.data});

  SalesRecord.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Sale>[];
      json['data'].forEach((v) {
        data!.add(Sale.fromJson(v));
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

class Sale {
  int? id;
  int? checkInId;
  int? productId;
  int? quantity;
  double? totalPrice;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Sale(
      {this.id,
        this.checkInId,
        this.productId,
        this.quantity,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.product});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkInId = json['check_in_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    totalPrice = double.parse(json['total_price'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['check_in_id'] = checkInId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}