class TemplateModel {
  int? status;
  TemplateMData? templateMData;

  TemplateModel({this.status, this.templateMData});

  TemplateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    templateMData = json['data'] != null ? TemplateMData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (templateMData != null) {
      data['data'] = templateMData!.toJson();
    }
    return data;
  }
}

class TemplateMData {
  int? currentPage;
  List<TemplateSData>? templateSData;
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

  TemplateMData(
      {this.currentPage,
        this.templateSData,
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

  TemplateMData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      templateSData = <TemplateSData>[];
      json['data'].forEach((v) {
        templateSData!.add(TemplateSData.fromJson(v));
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
    if (templateSData != null) {
      data['data'] = templateSData!.map((v) => v.toJson()).toList();
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

class TemplateSData {
  int? id;
  String? title;
  String? description;
  int? status;
  String? createdAt;
  List<DocumentHtml>? documentHtml;

  TemplateSData(
      {this.id,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.documentHtml});

  TemplateSData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    if (json['document_html'] != null) {
      documentHtml = <DocumentHtml>[];
      json['document_html'].forEach((v) {
        documentHtml!.add(DocumentHtml.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (documentHtml != null) {
      data['document_html'] =
          documentHtml!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentHtml {
  int? id;
  String? file;

  DocumentHtml({this.id, this.file});

  DocumentHtml.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['file'] = file;
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