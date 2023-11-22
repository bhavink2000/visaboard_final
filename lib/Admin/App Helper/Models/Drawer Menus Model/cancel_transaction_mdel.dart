class CancelTransactionModel {
  int? status;
  CancelTData? cancelTData;

  CancelTransactionModel({this.status, this.cancelTData});

  CancelTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cancelTData = json['data'] != null ? new CancelTData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (cancelTData != null) {
      data['data'] = cancelTData!.toJson();
    }
    return data;
  }
}

class CancelTData {
  int? currentPage;
  List<CTSData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  CancelTData(
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

  CancelTData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CTSData>[];
      json['data'].forEach((v) {
        data!.add(new CTSData.fromJson(v));
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

class CTSData {
  int? id;
  String? firstName;
  String? serviceName;
  String? letterTypeName;
  int? userId;
  String? orderPrice;
  int? status;
  String? paymentDate;
  String? lastName;
  String? middleName;
  String? price;
  String? agentFirstName;
  dynamic agentMiddleName;
  String? agentLastName;
  String? razorpayPaymentId;
  int? cancelStatus;
  String? cancelDate;
  String? createAt;

  CTSData(
      {this.id,
        this.firstName,
        this.serviceName,
        this.letterTypeName,
        this.userId,
        this.orderPrice,
        this.status,
        this.paymentDate,
        this.lastName,
        this.middleName,
        this.price,
        this.agentFirstName,
        this.agentMiddleName,
        this.agentLastName,
        this.razorpayPaymentId,
        this.cancelStatus,
        this.cancelDate,
        this.createAt});

  CTSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    userId = json['user_id'];
    orderPrice = json['order_price'];
    status = json['status'];
    paymentDate = json['payment_date'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    price = json['price'];
    agentFirstName = json['agent_first_name'];
    agentMiddleName = json['agent_middle_name'];
    agentLastName = json['agent_last_name'];
    razorpayPaymentId = json['razorpay_payment_id'];
    cancelStatus = json['cancel_status'];
    cancelDate = json['cancel_date'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['service_name'] = serviceName;
    data['letter_type_name'] = letterTypeName;
    data['user_id'] = userId;
    data['order_price'] = orderPrice;
    data['status'] = status;
    data['payment_date'] = paymentDate;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['price'] = price;
    data['agent_first_name'] = agentFirstName;
    data['agent_middle_name'] = agentMiddleName;
    data['agent_last_name'] = agentLastName;
    data['razorpay_payment_id'] = razorpayPaymentId;
    data['cancel_status'] = cancelStatus;
    data['cancel_date'] = cancelDate;
    data['create_at'] = createAt;
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
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}