class AgentsModel {
  int? status;
  AgentMData? agentmdata;

  AgentsModel({this.status, this.agentmdata});

  AgentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    agentmdata = json['data'] != null ? AgentMData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.agentmdata != null) {
      data['data'] = this.agentmdata!.toJson();
    }
    return data;
  }
}

class AgentMData {
  int? currentPage;
  List<AgentSData>? agentsdata;
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

  AgentMData(
      {this.currentPage,
        this.agentsdata,
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

  AgentMData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      agentsdata = <AgentSData>[];
      json['data'].forEach((v) {
        agentsdata!.add(AgentSData.fromJson(v));
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
    if (this.agentsdata != null) {
      data['data'] = this.agentsdata!.map((v) => v.toJson()).toList();
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

class AgentSData {
  int? id;
  String? firstName;
  String? emailId;
  String? mobileNo;
  String? status;
  String? createdAt;
  String? applyForStandee;
  String? applyForSticker;
  String? applyForVisitingCard;
  String? lastName;
  String? middleName;
  String? serviceTypeId;
  String? companyName;
  String? countryName;
  String? stateName;
  String? cityName;
  String? date;

  AgentSData(
      {this.id,
        this.firstName,
        this.emailId,
        this.mobileNo,
        this.status,
        this.createdAt,
        this.applyForStandee,
        this.applyForSticker,
        this.applyForVisitingCard,
        this.lastName,
        this.middleName,
        this.serviceTypeId,
        this.companyName,
        this.countryName,
        this.stateName,
        this.cityName,
        this.date});

  AgentSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    status = json['status'];
    createdAt = json['created_at'];
    applyForStandee = json['apply_for_standee'];
    applyForSticker = json['apply_for_sticker'];
    applyForVisitingCard = json['apply_for_visiting_card'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    serviceTypeId = json['service_type_id'];
    companyName = json['company_name'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['email_id'] = emailId;
    data['mobile_no'] = mobileNo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['apply_for_standee'] = applyForStandee;
    data['apply_for_sticker'] = applyForSticker;
    data['apply_for_visiting_card'] = applyForVisitingCard;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['service_type_id'] = serviceTypeId;
    data['company_name'] = companyName;
    data['country_name'] = countryName;
    data['state_name'] = stateName;
    data['city_name'] = cityName;
    data['date'] = date;
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