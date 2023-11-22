class ProfileModel {
  int? status;
  ProfileData? profiledata;

  ProfileModel({this.status, this.profiledata});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profiledata = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (profiledata != null) {
      data['data'] = profiledata!.toJson();
    }
    return data;
  }
}

class ProfileData {
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

  ProfileData(
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

  ProfileData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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