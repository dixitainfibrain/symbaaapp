class RegisterResponseModel {
  bool? status;
  String? message;
  RegisterResponseData? registerData;

  RegisterResponseModel({this.status, this.message, this.registerData});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    registerData = json['data'] != null ? RegisterResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.registerData != null) {
      data['data'] = this.registerData!.toJson();
    }
    return data;
  }
}

class RegisterResponseData {
  bool? auth;
  String? accessToken;
  String? expiryDate;
  User? user;

  RegisterResponseData({this.auth, this.accessToken, this.expiryDate, this.user});

  RegisterResponseData.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    accessToken = json['access_token'];
    expiryDate = json['expiryDate'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth'] = auth;
    data['access_token'] = accessToken;
    data['expiryDate'] = expiryDate;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? password;
  String? referrelcode;
  String? otp;
  String? otpExpiresAt;
  bool? isactive;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.firstname,
        this.lastname,
        this.phone,
        this.email,
        this.password,
        this.referrelcode,
        this.otp,
        this.otpExpiresAt,
        this.isactive,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    referrelcode = json['referrelcode'];
    otp = json['otp'];
    otpExpiresAt = json['otpExpiresAt'];
    isactive = json['isactive'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['referrelcode'] = referrelcode;
    data['otp'] = otp;
    data['otpExpiresAt'] = otpExpiresAt;
    data['isactive'] = isactive;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
