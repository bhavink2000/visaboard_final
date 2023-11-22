import 'dart:convert';

GraphModel graphModelFromJson(String str) => GraphModel.fromJson(json.decode(str));

String graphModelToJson(GraphModel data) => json.encode(data.toJson());

class GraphModel {
  GraphModel({
    required this.status,
    required this.data,
  });

  int status;
  Data data;

  factory GraphModel.fromJson(Map<String, dynamic> json) => GraphModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.charts,
  });

  Charts charts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    charts: Charts.fromJson(json["charts"]),
  );

  Map<String, dynamic> toJson() => {
    "charts": charts.toJson(),
  };
}

class Charts {
  Charts({
    required this.general,
    required this.subadmin,
    required this.generalFinanceChart,
    required this.todayGraph,
    required this.monthlyGraph,
    required this.mainGraph1,
    required this.mainGraph,
  });

  List<General> general;
  List<General> subadmin;
  GeneralFinanceChart generalFinanceChart;
  List<int> todayGraph;
  MonthlyGraph monthlyGraph;
  List<MainGraph> mainGraph1;
  List<MainGraph> mainGraph;

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
    general: List<General>.from(json["general"].map((x) => General.fromJson(x))),
    subadmin: List<General>.from(json["subadmin"].map((x) => General.fromJson(x))),
    generalFinanceChart: GeneralFinanceChart.fromJson(json["general_finance_chart"]),
    todayGraph: List<int>.from(json["today_graph"].map((x) => x)),
    monthlyGraph: MonthlyGraph.fromJson(json["monthly_graph"]),
    mainGraph1: List<MainGraph>.from(json["main_graph_1"].map((x) => MainGraph.fromJson(x))),
    mainGraph: List<MainGraph>.from(json["main_graph"].map((x) => MainGraph.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "general": List<dynamic>.from(general.map((x) => x.toJson())),
    "subadmin": List<dynamic>.from(subadmin.map((x) => x.toJson())),
    "general_finance_chart": generalFinanceChart.toJson(),
    "today_graph": List<dynamic>.from(todayGraph.map((x) => x)),
    "monthly_graph": monthlyGraph.toJson(),
    "main_graph_1": List<dynamic>.from(mainGraph1.map((x) => x.toJson())),
    "main_graph": List<dynamic>.from(mainGraph.map((x) => x.toJson())),
  };
}

class General {
  General({
    required this.name,
    required this.xmtprice,
    required this.y,
  });

  String name;
  int xmtprice;
  double y;

  factory General.fromJson(Map<String, dynamic> json) => General(
    name: json["name"],
    xmtprice: json["xmtprice"],
    y: json["y"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "xmtprice": xmtprice,
    "y": y,
  };
}

class GeneralFinanceChart {
  GeneralFinanceChart({
    required this.months,
    required this.values,
  });

  String months;
  Map<String, List<Value>> values;

  factory GeneralFinanceChart.fromJson(Map<String, dynamic> json) => GeneralFinanceChart(
    months: json["months"],
    values: Map.from(json["values"]).map((k, v) => MapEntry<String, List<Value>>(k, List<Value>.from(v.map((x) => Value.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "months": months,
    "values": Map.from(values).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
  };
}

class Value {
  Value({
    required this.y,
    required this.name,
  });

  int y;
  String name;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    y: json["y"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "y": y,
    "name": name,
  };
}

class MainGraph {
  MainGraph({
    required this.id,
    required this.serviceTypeId,
    required this.countryId,
    required this.name,
    required this.price,
    this.usdPrice,
    required this.allowUsd,
    required this.xmtprice,
    required this.y,
  });

  int id;
  int serviceTypeId;
  int countryId;
  String name;
  String price;
  String? usdPrice;
  int allowUsd;
  int xmtprice;
  int y;

  factory MainGraph.fromJson(Map<String, dynamic> json) => MainGraph(
    id: json["id"],
    serviceTypeId: json["service_type_id"],
    countryId: json["country_id"],
    name: json["name"],
    price: json["price"],
    usdPrice: json["usd_price"],
    allowUsd: json["allow_usd"],
    xmtprice: json["xmtprice"],
    y: json["y"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_type_id": serviceTypeId,
    "country_id": countryId,
    "name": name,
    "price": price,
    "usd_price": usdPrice,
    "allow_usd": allowUsd,
    "xmtprice": xmtprice,
    "y": y,
  };
}

class MonthlyGraph {
  MonthlyGraph({
    required this.days,
    required this.dates,
    required this.inr,
    required this.usd,
  });

  int days;
  String dates;
  List<Inr> inr;
  List<Inr> usd;

  factory MonthlyGraph.fromJson(Map<String, dynamic> json) => MonthlyGraph(
    days: json["days"],
    dates: json["dates"],
    inr: List<Inr>.from(json["INR"].map((x) => Inr.fromJson(x))),
    usd: List<Inr>.from(json["USD"].map((x) => Inr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "dates": dates,
    "INR": List<dynamic>.from(inr.map((x) => x.toJson())),
    "USD": List<dynamic>.from(usd.map((x) => x.toJson())),
  };
}

class Inr {
  Inr({
    required this.dt,
    required this.y,
    required this.count,
    required this.letters,
  });

  DateTime dt;
  int y;
  int count;
  List<Letter> letters;

  factory Inr.fromJson(Map<String, dynamic> json) => Inr(
    dt: DateTime.parse(json["dt"]),
    y: json["y"],
    count: json["count"],
    letters: List<Letter>.from(json["letters"].map((x) => Letter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dt": "${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}",
    "y": y,
    "count": count,
    "letters": List<dynamic>.from(letters.map((x) => x.toJson())),
  };
}

class Letter {
  Letter({
    required this.type,
    required this.price,
  });

  String type;
  String price;

  factory Letter.fromJson(Map<String, dynamic> json) => Letter(
    type: json["type"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "price": price,
  };
}