import 'package:shop_app/core/models/store_products_response.dart';

class SalesRecord {
  String? status;
  String? message;
  Records? data;

  SalesRecord({this.status, this.message, this.data});

  SalesRecord.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Records.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Records {
  List<Sales>? sales;
  List<Stocks>? stocks;

  Records({this.sales, this.stocks});

  Records.fromJson(Map<String, dynamic> json) {
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(Sales.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sales != null) {
      data['sales'] = sales!.map((v) => v.toJson()).toList();
    }
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sales {
  int? id;
  int? checkInId;
  int? productId;
  int? quantity;
  double? totalPrice;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Sales(
      {this.id,
        this.checkInId,
        this.productId,
        this.quantity,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.product});

  Sales.fromJson(Map<String, dynamic> json) {
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


class Stocks {
  int? id;
  String? uuid;
  int? userId;
  int? checkInId;
  int? productId;
  int? storeId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Stocks(
      {this.id,
        this.uuid,
        this.userId,
        this.checkInId,
        this.productId,
        this.storeId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.product});

  Stocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    userId = json['user_id'];
    checkInId = json['check_in_id'];
    productId = json['product_id'];
    storeId = json['store_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['user_id'] = userId;
    data['check_in_id'] = checkInId;
    data['product_id'] = productId;
    data['store_id'] = storeId;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
