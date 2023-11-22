class OrderVisaFileModel {
  int? status;
  String? unreadCount;
  OVFData? ovfData;

  OrderVisaFileModel({this.status, this.unreadCount, this.ovfData});

  OrderVisaFileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    unreadCount = json['unread_count'];
    ovfData = json['data'] != null ? OVFData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['unread_count'] = this.unreadCount;
    if (this.ovfData != null) {
      data['data'] = this.ovfData!.toJson();
    }
    return data;
  }
}

class OVFData {
  int? currentPage;
  List<OVFSData>? data;
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

  OVFData(
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

  OVFData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <OVFSData>[];
      json['data'].forEach((v) {
        data!.add(OVFSData.fromJson(v));
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

class OVFSData {
  int? id;
  String? firstName;
  String? agentFirstName;
  String? serviceName;
  String? letterTypeName;
  String? countryName;
  int? userId;
  String? razorpayPaymentId;
  int? status;
  int? userSopStatus;
  int? countryId;
  int? adminUnreadCount;
  String? orderPrice;
  String? lastName;
  String? middleName;
  String? agentLastName;
  String? adminFirstName;
  String? adminLastName;
  String? price;
  int? serviceTypeId;
  int? cancelStatus;
  String? walletOrderPrice;
  String? invoicePdf;
  String? paytmOrderPrice;
  String? companyName;
  int? showDropdown;
  dynamic statusDropdown;
  String? encUserId;
  String? encId;
  Action? action;
  String? createAt;
  String? updateAt;
  StatusDesc? statusDesc;

  OVFSData(
      {this.id,
        this.firstName,
        this.agentFirstName,
        this.serviceName,
        this.letterTypeName,
        this.countryName,
        this.userId,
        this.razorpayPaymentId,
        this.status,
        this.userSopStatus,
        this.countryId,
        this.adminUnreadCount,
        this.orderPrice,
        this.lastName,
        this.middleName,
        this.agentLastName,
        this.adminFirstName,
        this.adminLastName,
        this.price,
        this.serviceTypeId,
        this.cancelStatus,
        this.walletOrderPrice,
        this.invoicePdf,
        this.paytmOrderPrice,
        this.companyName,
        this.showDropdown,
        this.statusDropdown,
        this.encUserId,
        this.encId,
        this.action,
        this.createAt,
        this.updateAt,
        this.statusDesc});

  OVFSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    agentFirstName = json['agent_first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    countryName = json['country_name'];
    userId = json['user_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    status = json['status'];
    userSopStatus = json['user_sop_status'];
    countryId = json['country_id'];
    adminUnreadCount = json['admin_unread_count'];
    orderPrice = json['order_price'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    agentLastName = json['agent_last_name'];
    adminFirstName = json['admin_first_name'];
    adminLastName = json['admin_last_name'];
    price = json['price'];
    serviceTypeId = json['service_type_id'];
    cancelStatus = json['cancel_status'];
    walletOrderPrice = json['wallet_order_price'];
    invoicePdf = json['invoice_pdf'];
    paytmOrderPrice = json['paytm_order_price'];
    companyName = json['company_name'];
    showDropdown = json['show_dropdown'];
    statusDropdown = json['status_dropdown'];
    encUserId = json['enc_user_id'];
    encId = json['enc_id'];
    action =
    json['action'] != null ? Action.fromJson(json['action']) : null;
    createAt = json['create_at'];
    updateAt = json['update_at'];
    statusDesc = json['status_desc'] != null
        ? StatusDesc.fromJson(json['status_desc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['agent_first_name'] = this.agentFirstName;
    data['service_name'] = this.serviceName;
    data['letter_type_name'] = this.letterTypeName;
    data['country_name'] = this.countryName;
    data['user_id'] = this.userId;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['status'] = this.status;
    data['user_sop_status'] = this.userSopStatus;
    data['country_id'] = this.countryId;
    data['admin_unread_count'] = this.adminUnreadCount;
    data['order_price'] = this.orderPrice;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['agent_last_name'] = this.agentLastName;
    data['admin_first_name'] = this.adminFirstName;
    data['admin_last_name'] = this.adminLastName;
    data['price'] = this.price;
    data['service_type_id'] = this.serviceTypeId;
    data['cancel_status'] = this.cancelStatus;
    data['wallet_order_price'] = this.walletOrderPrice;
    data['invoice_pdf'] = this.invoicePdf;
    data['paytm_order_price'] = this.paytmOrderPrice;
    data['company_name'] = this.companyName;
    data['show_dropdown'] = this.showDropdown;
    data['status_dropdown'] = this.statusDropdown;
    data['enc_user_id'] = this.encUserId;
    data['enc_id'] = this.encId;
    if (this.action != null) {
      data['action'] = this.action!.toJson();
    }
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    if (this.statusDesc != null) {
      data['status_desc'] = this.statusDesc!.toJson();
    }
    return data;
  }
}

class Action {
  int? chatStatus;
  int? editStatus;
  int? sendMsg4UploadDocsStatus;
  int? uploadDocsStatus;
  int? addSubdomainStatus;
  int? invoicePdfStatus;

  Action(
      {this.chatStatus,
        this.editStatus,
        this.sendMsg4UploadDocsStatus,
        this.uploadDocsStatus,
        this.addSubdomainStatus,
        this.invoicePdfStatus});

  Action.fromJson(Map<String, dynamic> json) {
    chatStatus = json['chat_status'];
    editStatus = json['edit_status'];
    sendMsg4UploadDocsStatus = json['send_msg_4_upload_docs_status'];
    uploadDocsStatus = json['upload_docs_status'];
    addSubdomainStatus = json['add_subdomain_status'];
    invoicePdfStatus = json['invoice_pdf_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chat_status'] = this.chatStatus;
    data['edit_status'] = this.editStatus;
    data['send_msg_4_upload_docs_status'] = this.sendMsg4UploadDocsStatus;
    data['upload_docs_status'] = this.uploadDocsStatus;
    data['add_subdomain_status'] = this.addSubdomainStatus;
    data['invoice_pdf_status'] = this.invoicePdfStatus;
    return data;
  }
}

class StatusDesc {
  String? s1;
  String? s2;
  String? s3;

  StatusDesc({this.s1, this.s2, this.s3});

  StatusDesc.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
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