


class CustomersModel {
  CustomersDataModel? data;
  bool? success;

  CustomersModel({this.data, this.success});

  CustomersModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CustomersDataModel.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class CustomersDataModel {
  List<Residentials>? residentials;

  CustomersDataModel({this.residentials});

  CustomersDataModel.fromJson(Map<String, dynamic> json) {
    if (json['residentials'] != null) {
      residentials = <Residentials>[];
      json['residentials'].forEach((v) {
        residentials!.add(new Residentials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.residentials != null) {
      data['residentials'] = this.residentials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Residentials {
  String? id;
  String? name;
  String? status;
  String? photo;
  String? plan;

  Residentials({this.id, this.name, this.status, this.photo, this.plan});

  Residentials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    photo = json['photo'];
    plan = json['plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['plan'] = this.plan;
    return data;
  }
}
