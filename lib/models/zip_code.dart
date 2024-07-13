class ZipCodeModel {
  Data? data;
  bool? success;

  ZipCodeModel({this.data, this.success});

  ZipCodeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  City? city;
  State? state;
  String? neighborhood;
  String? complement;
  String? code;
  String? street;

  Data(
      {this.city,
      this.state,
      this.neighborhood,
      this.complement,
      this.code,
      this.street});

  Data.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ?  City.fromJson(json['city']) : null;
    state = json['state'] != null ?  State.fromJson(json['state']) : null;
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    code = json['code'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    data['neighborhood'] = this.neighborhood;
    data['complement'] = this.complement;
    data['code'] = this.code;
    data['street'] = this.street;
    return data;
  }
}

class City {
  String? ibge;
  String? name;
  int? ddd;

  City({this.ibge, this.name, this.ddd});

  City.fromJson(Map<String, dynamic> json) {
    ibge = json['ibge'];
    name = json['name'];
    ddd = json['ddd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ibge'] = this.ibge;
    data['name'] = this.name;
    data['ddd'] = this.ddd;
    return data;
  }
}

class State {
  String? sigla;

  State({this.sigla});

  State.fromJson(Map<String, dynamic> json) {
    sigla = json['sigla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sigla'] = this.sigla;
    return data;
  }
}