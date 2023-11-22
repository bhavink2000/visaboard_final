class DashBoardCounterModel {
  int? status;
  List<Data>? data;

  DashBoardCounterModel({this.status, this.data});

  DashBoardCounterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? serviceId;
  int? activeServiceCount;
  int? serviceCount;
  String? serviceName;

  Data(
      {this.serviceId,
        this.activeServiceCount,
        this.serviceCount,
        this.serviceName});

  Data.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    activeServiceCount = json['active_service_count'];
    serviceCount = json['service_count'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['active_service_count'] = this.activeServiceCount;
    data['service_count'] = this.serviceCount;
    data['service_name'] = this.serviceName;
    return data;
  }
}