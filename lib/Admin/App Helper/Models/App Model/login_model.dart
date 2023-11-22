class UserLogin {
  int? status;
  String? accessToken;
  String? tokenType;
  Data? data;
  int? expiresIn;

  UserLogin(
      {this.status,
        this.accessToken,
        this.tokenType,
        this.data,
        this.expiresIn});

  UserLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['expires_in'] = expiresIn;
    return data;
  }
}

class Data {
  int? id;
  int? parentId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? emailId;
  String? mobileNo;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.parentId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.emailId,
        this.mobileNo,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['parent_id'] = parentId;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email_id'] = emailId;
    data['mobile_no'] = mobileNo;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}