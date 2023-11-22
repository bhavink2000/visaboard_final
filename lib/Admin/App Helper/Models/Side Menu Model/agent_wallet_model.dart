class AgentWalletModel {
  int? status;
  MWData? data;

  AgentWalletModel({this.status, this.data});

  AgentWalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? MWData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MWData {
  int? currentPage;
  List<SWData>? data;
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

  MWData(
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

  MWData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SWData>[];
      json['data'].forEach((v) {
        data!.add(SWData.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class SWData {
  int? id;
  String? firstName;
  String? serviceName;
  String? letterTypeName;
  int? userId;
  String? creditAmount;
  String? debitAmount;
  int? debitTransactionType;
  String? creditDate;
  String? refundDate;
  String? paymentDate;
  String? createdAt;
  int? walletPaymentStatus;
  int? isWallet;
  int? status;
  String? lastName;
  String? orderPrice;
  int? userSopId;

  SWData(
      {this.id,
        this.firstName,
        this.serviceName,
        this.letterTypeName,
        this.userId,
        this.creditAmount,
        this.debitAmount,
        this.debitTransactionType,
        this.creditDate,
        this.refundDate,
        this.paymentDate,
        this.createdAt,
        this.walletPaymentStatus,
        this.isWallet,
        this.status,
        this.lastName,
        this.orderPrice,
        this.userSopId});

  SWData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    userId = json['user_id'];
    creditAmount = json['credit_amount'];
    debitAmount = json['debit_amount'];
    debitTransactionType = json['debit_transaction_type'];
    creditDate = json['credit_date'];
    refundDate = json['refund_date'];
    paymentDate = json['payment_date'];
    createdAt = json['created_at'];
    walletPaymentStatus = json['wallet_payment_status'];
    isWallet = json['is_wallet'];
    status = json['status'];
    lastName = json['last_name'];
    orderPrice = json['order_price'];
    userSopId = json['user_sop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['service_name'] = serviceName;
    data['letter_type_name'] = letterTypeName;
    data['user_id'] = userId;
    data['credit_amount'] = creditAmount;
    data['debit_amount'] = debitAmount;
    data['debit_transaction_type'] = debitTransactionType;
    data['credit_date'] = creditDate;
    data['refund_date'] = refundDate;
    data['payment_date'] = paymentDate;
    data['created_at'] = createdAt;
    data['wallet_payment_status'] = walletPaymentStatus;
    data['is_wallet'] = isWallet;
    data['status'] = status;
    data['last_name'] = lastName;
    data['order_price'] = orderPrice;
    data['user_sop_id'] = userSopId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}