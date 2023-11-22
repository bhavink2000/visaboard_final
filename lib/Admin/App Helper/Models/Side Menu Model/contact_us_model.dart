class ContactUsModel {
  int? status;
  ContactUsData? data;

  ContactUsModel({this.status, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ContactUsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ContactUsData {
  int? currentPage;
  List<CUData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  ContactUsData(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ContactUsData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CUData>[];
      json['data'].forEach((v) {
        data!.add(CUData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class CUData {
  int? id;
  String? companyName;
  String? emailId;
  String? firstName;
  String? lastName;
  dynamic countryName;
  dynamic stateName;
  String? comment;
  dynamic otherHelp;
  dynamic callTime;
  String? mobileNo;
  String? createdAt;
  dynamic startedDate;
  dynamic startedTime;

  CUData(
      {this.id,
        this.companyName,
        this.emailId,
        this.firstName,
        this.lastName,
        this.countryName,
        this.stateName,
        this.comment,
        this.otherHelp,
        this.callTime,
        this.mobileNo,
        this.createdAt,
        this.startedDate,
        this.startedTime});

  CUData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    emailId = json['email_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    comment = json['comment'];
    otherHelp = json['other_help'];
    callTime = json['call_time'];
    mobileNo = json['mobile_no'];
    createdAt = json['created_at'];
    startedDate = json['started_date'];
    startedTime = json['started_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['email_id'] = this.emailId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['comment'] = this.comment;
    data['other_help'] = this.otherHelp;
    data['call_time'] = this.callTime;
    data['mobile_no'] = this.mobileNo;
    data['created_at'] = this.createdAt;
    data['started_date'] = this.startedDate;
    data['started_time'] = this.startedTime;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}