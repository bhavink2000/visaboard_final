class TransactionModel {
  int? status;
  TransactionData? transactionData;

  TransactionModel({this.status, this.transactionData});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    transactionData = json['data'] != null ? new TransactionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.transactionData != null) {
      data['data'] = this.transactionData!.toJson();
    }
    return data;
  }
}

class TransactionData {
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

  TransactionData(
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

  TransactionData.fromJson(Map<String, dynamic> json) {
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
  String? serviceName;
  String? letterTypeName;
  int? allowUsd;
  int? userId;
  String? orderPrice;
  int? status;
  String? paymentDate;
  String? invoiceId;
  String? invoicePdf;
  String? lastName;
  String? middleName;
  String? price;
  int? countryId;
  String? agentFirstName;
  String? agentMiddleName;
  String? agentLastName;
  String? razorpayPaymentId;
  int? cancelStatus;
  String? cancelDate;
  String? encId;
  String? createDate;
  dynamic action;

  Data(
      {this.id,
        this.firstName,
        this.serviceName,
        this.letterTypeName,
        this.allowUsd,
        this.userId,
        this.orderPrice,
        this.status,
        this.paymentDate,
        this.invoiceId,
        this.invoicePdf,
        this.lastName,
        this.middleName,
        this.price,
        this.countryId,
        this.agentFirstName,
        this.agentMiddleName,
        this.agentLastName,
        this.razorpayPaymentId,
        this.cancelStatus,
        this.cancelDate,
        this.encId,
        this.createDate,
        this.action});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    allowUsd = json['allow_usd'];
    userId = json['user_id'];
    orderPrice = json['order_price'];
    status = json['status'];
    paymentDate = json['payment_date'];
    invoiceId = json['invoice_id'];
    invoicePdf = json['invoice_pdf'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    price = json['price'];
    countryId = json['country_id'];
    agentFirstName = json['agent_first_name'];
    agentMiddleName = json['agent_middle_name'];
    agentLastName = json['agent_last_name'];
    razorpayPaymentId = json['razorpay_payment_id'];
    cancelStatus = json['cancel_status'];
    cancelDate = json['cancel_date'];
    encId = json['enc_id'];
    createDate = json['create_date'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['service_name'] = this.serviceName;
    data['letter_type_name'] = this.letterTypeName;
    data['allow_usd'] = this.allowUsd;
    data['user_id'] = this.userId;
    data['order_price'] = this.orderPrice;
    data['status'] = this.status;
    data['payment_date'] = this.paymentDate;
    data['invoice_id'] = this.invoiceId;
    data['invoice_pdf'] = this.invoicePdf;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['price'] = this.price;
    data['country_id'] = this.countryId;
    data['agent_first_name'] = this.agentFirstName;
    data['agent_middle_name'] = this.agentMiddleName;
    data['agent_last_name'] = this.agentLastName;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['cancel_status'] = this.cancelStatus;
    data['cancel_date'] = this.cancelDate;
    data['enc_id'] = this.encId;
    data['create_date'] = this.createDate;
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