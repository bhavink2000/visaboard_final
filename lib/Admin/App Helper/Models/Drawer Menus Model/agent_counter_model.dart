class AgentCounterModel {
  int? status;
  AgentCounterData? agentCounterData;

  AgentCounterModel({this.status, this.agentCounterData});

  AgentCounterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    agentCounterData = json['data'] != null ? new AgentCounterData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.agentCounterData != null) {
      data['data'] = this.agentCounterData!.toJson();
    }
    return data;
  }
}

class AgentCounterData {
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

  AgentCounterData(
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

  AgentCounterData.fromJson(Map<String, dynamic> json) {
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
  String? emailId;
  String? mobileNo;
  int? status;
  String? lastName;
  String? middleName;
  dynamic serviceTypeId;
  String? companyName;
  String? countryName;
  String? stateName;
  String? cityName;
  String? createAt;
  int? sopOl;
  int? sopC;
  String? encAgentId;

  Data(
      {this.id,
        this.firstName,
        this.emailId,
        this.mobileNo,
        this.status,
        this.lastName,
        this.middleName,
        this.serviceTypeId,
        this.companyName,
        this.countryName,
        this.stateName,
        this.cityName,
        this.createAt,
        this.sopOl,
        this.sopC,
        this.encAgentId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    status = json['status'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    serviceTypeId = json['service_type_id'];
    companyName = json['company_name'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    createAt = json['create_at'];
    sopOl = json['sopOl'];
    sopC = json['sopC'];
    encAgentId = json['enc_agent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['email_id'] = this.emailId;
    data['mobile_no'] = this.mobileNo;
    data['status'] = this.status;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['service_type_id'] = this.serviceTypeId;
    data['company_name'] = this.companyName;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['create_at'] = this.createAt;
    data['sopOl'] = this.sopOl;
    data['sopC'] = this.sopC;
    data['enc_agent_id'] = this.encAgentId;
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