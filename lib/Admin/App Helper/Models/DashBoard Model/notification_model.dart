class NotificationModel {
  int? status;
  String? unreadCount;
  NotificationData? notificationData;

  NotificationModel({this.status, this.unreadCount, this.notificationData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    unreadCount = json['unread_count'];
    notificationData = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['unread_count'] = unreadCount;
    if (notificationData != null) {
      data['data'] = notificationData!.toJson();
    }
    return data;
  }
}

class NotificationData {
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
  String? prevPageUrl;
  int? to;
  int? total;

  NotificationData(
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

  NotificationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
    data['id'] = id;
    data['first_name'] = firstName;
    data['agent_first_name'] = agentFirstName;
    data['service_name'] = serviceName;
    data['letter_type_name'] = letterTypeName;
    data['country_name'] = countryName;
    data['user_id'] = userId;
    data['razorpay_payment_id'] = razorpayPaymentId;
    data['status'] = status;
    data['user_sop_status'] = userSopStatus;
    data['country_id'] = countryId;
    data['admin_unread_count'] = adminUnreadCount;
    data['order_price'] = orderPrice;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['agent_last_name'] = agentLastName;
    data['admin_first_name'] = adminFirstName;
    data['admin_last_name'] = adminLastName;
    data['price'] = price;
    data['service_type_id'] = serviceTypeId;
    data['cancel_status'] = cancelStatus;
    data['wallet_order_price'] = walletOrderPrice;
    data['invoice_pdf'] = invoicePdf;
    data['paytm_order_price'] = paytmOrderPrice;
    data['company_name'] = companyName;
    data['show_dropdown'] = showDropdown;
    data['status_dropdown'] = statusDropdown;
    data['enc_user_id'] = encUserId;
    data['enc_id'] = encId;
    if (action != null) {
      data['action'] = action!.toJson();
    }
    data['create_at'] = createAt;
    data['update_at'] = updateAt;
    if (statusDesc != null) {
      data['status_desc'] = statusDesc!.toJson();
    }
    return data;
  }
}

class Action {
  int? editStatus;
  int? sendMsg4UploadDocsStatus;
  int? uploadDocsStatus;
  int? chatStatus;
  int? addSubdomainStatus;
  int? invoicePdfStatus;

  Action(
      {this.editStatus,
        this.sendMsg4UploadDocsStatus,
        this.uploadDocsStatus,
        this.chatStatus,
        this.addSubdomainStatus,
        this.invoicePdfStatus});

  Action.fromJson(Map<String, dynamic> json) {
    editStatus = json['edit_status'];
    sendMsg4UploadDocsStatus = json['send_msg_4_upload_docs_status'];
    uploadDocsStatus = json['upload_docs_status'];
    chatStatus = json['chat_status'];
    addSubdomainStatus = json['add_subdomain_status'];
    invoicePdfStatus = json['invoice_pdf_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['edit_status'] = editStatus;
    data['send_msg_4_upload_docs_status'] = sendMsg4UploadDocsStatus;
    data['upload_docs_status'] = uploadDocsStatus;
    data['chat_status'] = chatStatus;
    data['add_subdomain_status'] = addSubdomainStatus;
    data['invoice_pdf_status'] = invoicePdfStatus;
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
    data['1'] = s1;
    data['2'] = s2;
    data['3'] = s3;
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
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}