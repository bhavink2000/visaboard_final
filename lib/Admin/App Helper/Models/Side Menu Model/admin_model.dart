class AdminModel {
  int? status;
  AdminMData? adminmdata;

  AdminModel({this.status, this.adminmdata});

  AdminModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    adminmdata = json['data'] != null ? AdminMData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.adminmdata != null) {
      data['data'] = this.adminmdata!.toJson();
    }
    return data;
  }
}

class AdminMData {
  int? currentPage;
  List<AdminSData>? adminsdata;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  AdminMData(
      {this.currentPage,
        this.adminsdata,
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

  AdminMData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      adminsdata = <AdminSData>[];
      json['data'].forEach((v) {
        adminsdata!.add(AdminSData.fromJson(v));
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
    if (this.adminsdata != null) {
      data['data'] = this.adminsdata!.map((v) => v.toJson()).toList();
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

class AdminSData {
  int? id;
  String? firstName;
  String? emailId;
  String? mobileNo;
  String? status;
  String? createdAt;
  String? lastName;
  String? middleName;
  String? date;

  AdminSData(
      {this.id,
        this.firstName,
        this.emailId,
        this.mobileNo,
        this.status,
        this.createdAt,
        this.lastName,
        this.middleName,
        this.date});

  AdminSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    status = json['status'];
    createdAt = json['created_at'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['email_id'] = this.emailId;
    data['mobile_no'] = this.mobileNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['date'] = this.date;
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