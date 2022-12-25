class UserProfile {
  String? status;
  String? message;
  Profile? data;

  UserProfile({this.status, this.message, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Profile.fromJson(json['data']) : null;
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

class Profile {
  int? id;
  String? uuid;
  String? firstname;
  String? lastname;
  String? email;
  String? address;
  String? phone;
  String? imageUrl;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.uuid,
      this.firstname,
      this.lastname,
      this.email,
      this.address,
      this.phone,
      this.imageUrl,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    imageUrl = json['image_url'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['image_url'] = imageUrl;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
