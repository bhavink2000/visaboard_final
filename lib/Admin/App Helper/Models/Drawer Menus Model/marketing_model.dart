class MarketingModel {
  int? status;
  MarketingData? marketingData;

  MarketingModel({this.status, this.marketingData});

  MarketingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    marketingData = json['data'] != null ? new MarketingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.marketingData != null) {
      data['data'] = this.marketingData!.toJson();
    }
    return data;
  }
}

class MarketingData {
  int? currentPage;
  List<MSData>? data;
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

  MarketingData(
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

  MarketingData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MSData>[];
      json['data'].forEach((v) {
        data!.add(new MSData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class MSData {
  int? id;
  String? name;
  String? emailId;
  String? contactNumber;
  int? status;
  String? companyName;
  String? companyAddress;
  String? photo;
  String? comment;
  int? registered;
  String? adminFirstName;
  String? adminLastName;
  String? subadminName;
  String? isRegistered;
  String? createAt;

  MSData(
      {this.id,
        this.name,
        this.emailId,
        this.contactNumber,
        this.status,
        this.companyName,
        this.companyAddress,
        this.photo,
        this.comment,
        this.registered,
        this.adminFirstName,
        this.adminLastName,
        this.subadminName,
        this.isRegistered,
        this.createAt});

  MSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailId = json['email_id'];
    contactNumber = json['contact_number'];
    status = json['status'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    photo = json['photo'];
    comment = json['comment'];
    registered = json['registered'];
    adminFirstName = json['admin_first_name'];
    adminLastName = json['admin_last_name'];
    subadminName = json['subadmin_name'];
    isRegistered = json['is_registered'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email_id'] = this.emailId;
    data['contact_number'] = this.contactNumber;
    data['status'] = this.status;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['photo'] = this.photo;
    data['comment'] = this.comment;
    data['registered'] = this.registered;
    data['admin_first_name'] = this.adminFirstName;
    data['admin_last_name'] = this.adminLastName;
    data['subadmin_name'] = this.subadminName;
    data['is_registered'] = this.isRegistered;
    data['create_at'] = this.createAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}