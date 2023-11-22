class AgentQRCodeModel {
  int? status;
  AQRData? aqrData;

  AgentQRCodeModel({this.status, this.aqrData});

  AgentQRCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    aqrData = json['data'] != null ? AQRData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (aqrData != null) {
      data['data'] = aqrData!.toJson();
    }
    return data;
  }
}

class AQRData {
  Agents? agents;

  AQRData({this.agents});

  AQRData.fromJson(Map<String, dynamic> json) {
    agents =
    json['agents'] != null ? Agents.fromJson(json['agents']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (agents != null) {
      data['agents'] = agents!.toJson();
    }
    return data;
  }
}

class Agents {
  int? currentPage;
  List<AGRSData>? agrsData;
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

  Agents(
      {this.currentPage,
        this.agrsData,
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

  Agents.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      agrsData = <AGRSData>[];
      json['data'].forEach((v) {
        agrsData!.add(AGRSData.fromJson(v));
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
    if (agrsData != null) {
      data['data'] = agrsData!.map((v) => v.toJson()).toList();
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

class AGRSData {
  int? id;
  int? parentId;
  String? referralCode;
  String? firstName;
  String? middleName;
  String? lastName;
  String? emailId;
  String? altEmailId;
  String? mobileNo;
  dynamic altMobileNo;
  String? image;
  String? bankName;
  String? accountName;
  String? accountNo;
  String? ifscNo;
  String? bankAddress;
  dynamic serviceTypeId;
  dynamic letterTypeId;
  dynamic totalSubscriptionStudent;
  dynamic totalRemainStudent;
  String? totalWalletAmount;
  int? opdStatus;
  int? status;
  int? bothSendEmailStatus;
  int? firstTimeLoginStatus;
  String? companyName;
  String? companyAddress;
  int? countryId;
  int? stateId;
  int? cityId;
  String? postCode;
  String? address;
  String? gstNo;
  String? orCodeImage;
  int? applyForStandee;
  int? applyForSticker;
  int? applyForVisitingCard;
  dynamic linkedinLink;
  dynamic facebookLink;
  dynamic instagramLink;
  dynamic twitterLink;
  dynamic youtubeLink;
  dynamic websiteLink;
  dynamic businessRegistrationProof;
  String? createAt;
  String? updateAt;

  AGRSData(
      {this.id,
        this.parentId,
        this.referralCode,
        this.firstName,
        this.middleName,
        this.lastName,
        this.emailId,
        this.altEmailId,
        this.mobileNo,
        this.altMobileNo,
        this.image,
        this.bankName,
        this.accountName,
        this.accountNo,
        this.ifscNo,
        this.bankAddress,
        this.serviceTypeId,
        this.letterTypeId,
        this.totalSubscriptionStudent,
        this.totalRemainStudent,
        this.totalWalletAmount,
        this.opdStatus,
        this.status,
        this.bothSendEmailStatus,
        this.firstTimeLoginStatus,
        this.companyName,
        this.companyAddress,
        this.countryId,
        this.stateId,
        this.cityId,
        this.postCode,
        this.address,
        this.gstNo,
        this.orCodeImage,
        this.applyForStandee,
        this.applyForSticker,
        this.applyForVisitingCard,
        this.linkedinLink,
        this.facebookLink,
        this.instagramLink,
        this.twitterLink,
        this.youtubeLink,
        this.websiteLink,
        this.businessRegistrationProof,
        this.createAt,
        this.updateAt});

  AGRSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    referralCode = json['referral_code'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    emailId = json['email_id'];
    altEmailId = json['alt_email_id'];
    mobileNo = json['mobile_no'];
    altMobileNo = json['alt_mobile_no'];
    image = json['image'];
    bankName = json['bank_name'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    ifscNo = json['ifsc_no'];
    bankAddress = json['bank_address'];
    serviceTypeId = json['service_type_id'];
    letterTypeId = json['letter_type_id'];
    totalSubscriptionStudent = json['total_subscription_student'];
    totalRemainStudent = json['total_remain_student'];
    totalWalletAmount = json['total_wallet_amount'];
    opdStatus = json['opd_status'];
    status = json['status'];
    bothSendEmailStatus = json['both_send_email_status'];
    firstTimeLoginStatus = json['first_time_login_status'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    postCode = json['post_code'];
    address = json['address'];
    gstNo = json['gst_no'];
    orCodeImage = json['or_code_image'];
    applyForStandee = json['apply_for_standee'];
    applyForSticker = json['apply_for_sticker'];
    applyForVisitingCard = json['apply_for_visiting_card'];
    linkedinLink = json['linkedin_link'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    youtubeLink = json['youtube_link'];
    websiteLink = json['website_link'];
    businessRegistrationProof = json['business_registration_proof'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['parent_id'] = parentId;
    data['referral_code'] = referralCode;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email_id'] = emailId;
    data['alt_email_id'] = altEmailId;
    data['mobile_no'] = mobileNo;
    data['alt_mobile_no'] = altMobileNo;
    data['image'] = image;
    data['bank_name'] = bankName;
    data['account_name'] = accountName;
    data['account_no'] = accountNo;
    data['ifsc_no'] = ifscNo;
    data['bank_address'] = bankAddress;
    data['service_type_id'] = serviceTypeId;
    data['letter_type_id'] = letterTypeId;
    data['total_subscription_student'] = totalSubscriptionStudent;
    data['total_remain_student'] = totalRemainStudent;
    data['total_wallet_amount'] = totalWalletAmount;
    data['opd_status'] = opdStatus;
    data['status'] = status;
    data['both_send_email_status'] = bothSendEmailStatus;
    data['first_time_login_status'] = firstTimeLoginStatus;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['post_code'] = postCode;
    data['address'] = address;
    data['gst_no'] = gstNo;
    data['or_code_image'] = orCodeImage;
    data['apply_for_standee'] = applyForStandee;
    data['apply_for_sticker'] = applyForSticker;
    data['apply_for_visiting_card'] = applyForVisitingCard;
    data['linkedin_link'] = linkedinLink;
    data['facebook_link'] = facebookLink;
    data['instagram_link'] = instagramLink;
    data['twitter_link'] = twitterLink;
    data['youtube_link'] = youtubeLink;
    data['website_link'] = websiteLink;
    data['business_registration_proof'] = businessRegistrationProof;
    data['create_at'] = createAt;
    data['update_at'] = updateAt;
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