class CatsFacts {
  Status? status;
  String? sId;
  int? iV;
  String? text;
  String? source;
  String? updatedAt;
  String? type;
  String? createdAt;
  bool? deleted;
  bool? used;
  String? user;

  CatsFacts(
      {this.status,
      this.sId,
      this.iV,
      this.text,
      this.source,
      this.updatedAt,
      this.type,
      this.createdAt,
      this.deleted,
      this.used,
      this.user});

  CatsFacts.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    sId = json['_id'];
    iV = json['__v'];
    text = json['text'];
    source = json['source'];
    updatedAt = json['updatedAt'];
    type = json['type'];
    createdAt = json['createdAt'];
    deleted = json['deleted'];
    used = json['used'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['text'] = this.text;
    data['source'] = this.source;
    data['updatedAt'] = this.updatedAt;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['deleted'] = this.deleted;
    data['used'] = this.used;
    data['user'] = this.user;
    return data;
  }
}

class Status {
  bool? verified;
  int? sentCount;

  Status({this.verified, this.sentCount});

  Status.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    sentCount = json['sentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['sentCount'] = this.sentCount;
    return data;
  }
}


