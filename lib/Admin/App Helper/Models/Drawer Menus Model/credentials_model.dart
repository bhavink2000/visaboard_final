class CredentialsModel {
  int? status;
  CredentialData? credentialData;

  CredentialsModel({this.status, this.credentialData});

  CredentialsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    credentialData = json['data'] != null ? new CredentialData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.credentialData != null) {
      data['data'] = this.credentialData!.toJson();
    }
    return data;
  }
}

class CredentialData {
  int? currentPage;
  List<CSData>? data;
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

  CredentialData(
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

  CredentialData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CSData>[];
      json['data'].forEach((v) {
        data!.add(new CSData.fromJson(v));
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

class CSData {
  int? id;
  String? appName;
  String? userName;
  String? userId;
  String? password;
  String? link;
  String? adminFirstName;
  String? adminLastName;
  String? createAt;

  CSData(
      {this.id,
        this.appName,
        this.userName,
        this.userId,
        this.password,
        this.link,
        this.adminFirstName,
        this.adminLastName,
        this.createAt});

  CSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    userName = json['user_name'];
    userId = json['user_id'];
    password = json['password'];
    link = json['link'];
    adminFirstName = json['admin_first_name'];
    adminLastName = json['admin_last_name'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_name'] = this.appName;
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    data['password'] = this.password;
    data['link'] = this.link;
    data['admin_first_name'] = this.adminFirstName;
    data['admin_last_name'] = this.adminLastName;
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