class OVFChatModel {
  int? status;
  ChatData? chatData;

  OVFChatModel({this.status, this.chatData});

  OVFChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    chatData = json['data'] != null ? ChatData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.chatData != null) {
      data['data'] = this.chatData!.toJson();
    }
    return data;
  }
}

class ChatData {
  int? id;
  List<UserInboxes>? userInboxes;
  UserSop? userSop;

  ChatData({this.id, this.userInboxes, this.userSop});

  ChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['user_inboxes'] != null) {
      userInboxes = <UserInboxes>[];
      json['user_inboxes'].forEach((v) {
        userInboxes!.add(UserInboxes.fromJson(v));
      });
    }
    userSop = json['user_sop'] != null
        ? UserSop.fromJson(json['user_sop'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userInboxes != null) {
      data['user_inboxes'] = this.userInboxes!.map((v) => v.toJson()).toList();
    }
    if (this.userSop != null) {
      data['user_sop'] = this.userSop!.toJson();
    }
    return data;
  }
}

class UserInboxes {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  dynamic middleName;
  String? subject;
  String? message;
  int? sendByAdmin;
  String? adminFirstName;
  String? adminLastName;
  List<Files>? files;
  String? encChatId;
  String? createAt;

  UserInboxes(
      {this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.middleName,
        this.subject,
        this.message,
        this.sendByAdmin,
        this.adminFirstName,
        this.adminLastName,
        this.files,
        this.encChatId,
        this.createAt});

  UserInboxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    subject = json['subject'];
    message = json['message'];
    sendByAdmin = json['send_by_admin'];
    adminFirstName = json['admin_first_name'];
    adminLastName = json['admin_last_name'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    encChatId = json['enc_chat_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['send_by_admin'] = this.sendByAdmin;
    data['admin_first_name'] = this.adminFirstName;
    data['admin_last_name'] = this.adminLastName;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['enc_chat_id'] = this.encChatId;
    data['create_at'] = this.createAt;
    return data;
  }
}

class Files {
  String? file;
  String? nfile;
  String? encattchmntid;
  int? id;

  Files({this.file, this.nfile, this.encattchmntid, this.id});

  Files.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    nfile = json['nfile'];
    encattchmntid = json['encattchmntid'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['file'] = this.file;
    data['nfile'] = this.nfile;
    data['encattchmntid'] = this.encattchmntid;
    data['id'] = this.id;
    return data;
  }
}

class UserSop {
  int? id;
  String? userFirstName;
  String? serviceName;
  String? letterTypeName;
  String? countryName;
  String? userLastName;
  String? userMiddleName;
  String? orderPrice;
  String? razorpayPaymentId;
  String? price;
  int? serviceTypeId;
  int? agentId;
  int? userSopId;

  UserSop(
      {this.id,
        this.userFirstName,
        this.serviceName,
        this.letterTypeName,
        this.countryName,
        this.userLastName,
        this.userMiddleName,
        this.orderPrice,
        this.razorpayPaymentId,
        this.price,
        this.serviceTypeId,
        this.agentId,
        this.userSopId});

  UserSop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userFirstName = json['user_first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    countryName = json['country_name'];
    userLastName = json['user_last_name'];
    userMiddleName = json['user_middle_name'];
    orderPrice = json['order_price'];
    razorpayPaymentId = json['razorpay_payment_id'];
    price = json['price'];
    serviceTypeId = json['service_type_id'];
    agentId = json['agent_id'];
    userSopId = json['user_sop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_first_name'] = this.userFirstName;
    data['service_name'] = this.serviceName;
    data['letter_type_name'] = this.letterTypeName;
    data['country_name'] = this.countryName;
    data['user_last_name'] = this.userLastName;
    data['user_middle_name'] = this.userMiddleName;
    data['order_price'] = this.orderPrice;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['price'] = this.price;
    data['service_type_id'] = this.serviceTypeId;
    data['agent_id'] = this.agentId;
    data['user_sop_id'] = this.userSopId;
    return data;
  }
}