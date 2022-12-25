class StoreProductResponse {
  String? status;
  String? message;
  List<StoreProductData>? data;

  StoreProductResponse({this.status, this.message, this.data});

  StoreProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoreProductData>[];
      json['data'].forEach((v) {
        data!.add(StoreProductData.fromJson(v));
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

class StoreProductData {
  int? id;
  int? storeId;
  int? productId;
  int? quantity;
  Product? product;

  StoreProductData({this.id, this.storeId, this.productId, this.quantity, this.product});

  StoreProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
class Product {
  int? id;
  String? name;
  String? price;

  Product({this.id, this.name, this.price});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}