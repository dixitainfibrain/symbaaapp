class ResendOtpResponseModel {
  bool? status;
  String? message;
  ResendOtpData? data;

  ResendOtpResponseModel({this.status, this.message, this.data});

  ResendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ResendOtpData.fromJson(json['data']) : null;
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

class ResendOtpData {
  String? sId;
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? password;
  String? referrelcode;
  String? otp;
  String? otpExpiresAt;
  bool? isactive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ResendOtpData(
      {this.sId,
        this.firstname,
        this.lastname,
        this.phone,
        this.email,
        this.password,
        this.referrelcode,
        this.otp,
        this.otpExpiresAt,
        this.isactive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ResendOtpData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    referrelcode = json['referrelcode'];
    otp = json['otp'];
    otpExpiresAt = json['otpExpiresAt'];
    isactive = json['isactive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['referrelcode'] = referrelcode;
    data['otp'] = otp;
    data['otpExpiresAt'] = otpExpiresAt;
    data['isactive'] = isactive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
