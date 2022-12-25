class NearbyStoreResponse {
  String? status;
  String? message;
  List<Store>? store;

  NearbyStoreResponse({this.status, this.message, this.store});

  NearbyStoreResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      store = <Store>[];
      json['data'].forEach((v) {
        store!.add(Store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (store != null) {
      data['data'] = store!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? uuid;
  String? address;
  String? longitude;
  String? latitude;
  double? distance;

  Store(
      {this.id,
        this.name,
        this.uuid,
        this.address,
        this.longitude,
        this.latitude,
        this.distance});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uuid = json['uuid'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uuid'] = uuid;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['distance'] = distance;
    return data;
  }
}
