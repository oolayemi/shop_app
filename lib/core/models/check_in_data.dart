import 'nearby_store.dart';

class CheckInData {
  int? id;
  String? uuid;
  int? userId;
  int? storeId;
  int? isCheckedOut;
  String? checkoutTime;
  String? comment;
  String? createdAt;
  String? updatedAt;
  Store? store;

  CheckInData(
      {this.id,
        this.uuid,
        this.userId,
        this.storeId,
        this.isCheckedOut,
        this.checkoutTime,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.store});

  CheckInData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    userId = json['user_id'];
    storeId = json['store_id'];
    isCheckedOut = json['is_checked_out'];
    checkoutTime = json['checkout_time'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['uuid'] = uuid;
    data['user_id'] = userId;
    data['store_id'] = storeId;
    data['is_checked_out'] = isCheckedOut;
    data['checkout_time'] = checkoutTime;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }
}