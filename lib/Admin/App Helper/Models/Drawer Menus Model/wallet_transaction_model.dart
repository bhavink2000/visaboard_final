class WalletTransactionModel {
  int? status;
  WalletTData? walletTData;

  WalletTransactionModel({this.status, this.walletTData});

  WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    walletTData = json['data'] != null ? new WalletTData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (walletTData != null) {
      data['data'] = walletTData!.toJson();
    }
    return data;
  }
}

class WalletTData {
  int? currentPage;
  List<WTSData>? data;
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

  WalletTData(
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

  WalletTData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <WTSData>[];
      json['data'].forEach((v) {
        data!.add(new WTSData.fromJson(v));
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

class WTSData {
  int? id;
  String? creditAmount;
  String? creditDate;
  String? debitAmount;
  String? debitDate;
  int? creditTransactionType;
  int? debitTransactionType;
  int? withdrawStatus;
  String? agentFirstName;
  String? agentMiddleName;
  int? agentId;
  String? agentLastName;
  int? countryId;
  String? status;
  int? isWallet;
  StatusList? statusList;
  String? encId;

  WTSData(
      {this.id,
        this.creditAmount,
        this.creditDate,
        this.debitAmount,
        this.debitDate,
        this.creditTransactionType,
        this.debitTransactionType,
        this.withdrawStatus,
        this.agentFirstName,
        this.agentMiddleName,
        this.agentId,
        this.agentLastName,
        this.countryId,
        this.status,
        this.isWallet,
        this.statusList,
        this.encId});

  WTSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creditAmount = json['credit_amount'];
    creditDate = json['credit_date'];
    debitAmount = json['debit_amount'];
    debitDate = json['debit_date'];
    creditTransactionType = json['credit_transaction_type'];
    debitTransactionType = json['debit_transaction_type'];
    withdrawStatus = json['withdraw_status'];
    agentFirstName = json['agent_first_name'];
    agentMiddleName = json['agent_middle_name'];
    agentId = json['agent_id'];
    agentLastName = json['agent_last_name'];
    countryId = json['country_id'];
    status = json['status'];
    isWallet = json['is_wallet'];
    statusList = json['status_list'] != null
        ? new StatusList.fromJson(json['status_list'])
        : null;
    encId = json['enc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['credit_amount'] = creditAmount;
    data['credit_date'] = creditDate;
    data['debit_amount'] = debitAmount;
    data['debit_date'] = debitDate;
    data['credit_transaction_type'] = creditTransactionType;
    data['debit_transaction_type'] = debitTransactionType;
    data['withdraw_status'] = withdrawStatus;
    data['agent_first_name'] = agentFirstName;
    data['agent_middle_name'] = agentMiddleName;
    data['agent_id'] = agentId;
    data['agent_last_name'] = agentLastName;
    data['country_id'] = countryId;
    data['status'] = status;
    data['is_wallet'] = isWallet;
    if (statusList != null) {
      data['status_list'] = statusList!.toJson();
    }
    data['enc_id'] = encId;
    return data;
  }
}

class StatusList {
  String? s0;
  String? s1;
  String? s2;

  StatusList({this.s0, this.s1, this.s2});

  StatusList.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = s0;
    data['1'] = s1;
    data['2'] = s2;
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