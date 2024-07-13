class ResidentialContactsModel {
  ResidentialContactsData? data;
  bool? success;

  ResidentialContactsModel({this.data, this.success});

  ResidentialContactsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  ResidentialContactsData.fromJson(json['data']) : null;
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

class ResidentialContactsData {
  List<ResidentialContacts>? contacts;

  ResidentialContactsData({this.contacts});

  ResidentialContactsData.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = <ResidentialContacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new ResidentialContacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResidentialContacts {
  String? id;
  String? name;
  String? number;
  String? photo;

  ResidentialContacts({this.id, this.name, this.number, this.photo});

  ResidentialContacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['photo'] = this.photo;
    return data;
  }
}
