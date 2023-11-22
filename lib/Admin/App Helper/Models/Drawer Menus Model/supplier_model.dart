class SupplierModel {
  int? status;
  SupplierData? supplierData;

  SupplierModel({this.status, this.supplierData});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    supplierData = json['data'] != null ? new SupplierData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.supplierData != null) {
      data['data'] = this.supplierData!.toJson();
    }
    return data;
  }
}

class SupplierData {
  int? currentPage;
  List<SSData>? data;
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

  SupplierData(
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

  SupplierData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SSData>[];
      json['data'].forEach((v) {
        data!.add(new SSData.fromJson(v));
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

class SSData {
  int? id;
  String? countryName;
  String? universityName;
  String? universityEmailId;
  String? agencyName;
  String? agencyEmailId;
  String? contactPersonName;
  String? contactNumber;
  String? adminFirstName;
  String? adminLastName;
  String? createAt;

  SSData(
      {this.id,
        this.countryName,
        this.universityName,
        this.universityEmailId,
        this.agencyName,
        this.agencyEmailId,
        this.contactPersonName,
        this.contactNumber,
        this.adminFirstName,
        this.adminLastName,
        this.createAt});

  SSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    universityName = json['university_name'];
    universityEmailId = json['university_email_id'];
    agencyName = json['agency_name'];
    agencyEmailId = json['agency_email_id'];
    contactPersonName = json['contact_person_name'];
    contactNumber = json['contact_number'];
    adminFirstName = json['admin_first_name'];
    adminLastName = json['admin_last_name'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_name'] = this.countryName;
    data['university_name'] = this.universityName;
    data['university_email_id'] = this.universityEmailId;
    data['agency_name'] = this.agencyName;
    data['agency_email_id'] = this.agencyEmailId;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_number'] = this.contactNumber;
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