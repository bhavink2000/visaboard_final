class ClientModel {
  int? status;
  ClientData? clientData;

  ClientModel({this.status, this.clientData});

  ClientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    clientData = json['data'] != null ? new ClientData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.clientData != null) {
      data['data'] = this.clientData!.toJson();
    }
    return data;
  }
}

class ClientData {
  int? currentPage;
  List<Data>? data;
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

  ClientData(
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

  ClientData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? firstName;
  String? agentFirstName;
  String? serviceName;
  String? letterTypeName;
  String? price;
  int? letterTypeId;
  String? countryName;
  int? status;
  String? mobileNo;
  int? userSopId;
  String? lastName;
  String? middleName;
  String? agentLastName;
  dynamic razorpayPaymentId;
  int? serviceTypeId;
  String? companyName;
  int? countryId;
  int? cancelStatus;
  String? createAt;
  int? flag;
  String? action;

  Data(
      {this.id,
        this.firstName,
        this.agentFirstName,
        this.serviceName,
        this.letterTypeName,
        this.price,
        this.letterTypeId,
        this.countryName,
        this.status,
        this.mobileNo,
        this.userSopId,
        this.lastName,
        this.middleName,
        this.agentLastName,
        this.razorpayPaymentId,
        this.serviceTypeId,
        this.companyName,
        this.countryId,
        this.cancelStatus,
        this.createAt,
        this.flag,
        this.action});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    agentFirstName = json['agent_first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    price = json['price'];
    letterTypeId = json['letter_type_id'];
    countryName = json['country_name'];
    status = json['status'];
    mobileNo = json['mobile_no'];
    userSopId = json['user_sop_id'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    agentLastName = json['agent_last_name'];
    razorpayPaymentId = json['razorpay_payment_id'];
    serviceTypeId = json['service_type_id'];
    companyName = json['company_name'];
    countryId = json['country_id'];
    cancelStatus = json['cancel_status'];
    createAt = json['create_at'];
    flag = json['flag'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['agent_first_name'] = this.agentFirstName;
    data['service_name'] = this.serviceName;
    data['letter_type_name'] = this.letterTypeName;
    data['price'] = this.price;
    data['letter_type_id'] = this.letterTypeId;
    data['country_name'] = this.countryName;
    data['status'] = this.status;
    data['mobile_no'] = this.mobileNo;
    data['user_sop_id'] = this.userSopId;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['agent_last_name'] = this.agentLastName;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['service_type_id'] = this.serviceTypeId;
    data['company_name'] = this.companyName;
    data['country_id'] = this.countryId;
    data['cancel_status'] = this.cancelStatus;
    data['create_at'] = this.createAt;
    data['flag'] = this.flag;
    data['action'] = this.action;
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