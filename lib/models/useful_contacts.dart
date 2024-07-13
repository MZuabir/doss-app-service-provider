class UsefullContactsModel {
  String? object;
  List<Errors>? errors;
  String? message;
  bool? success;
  UsefullContactsData? data;

  UsefullContactsModel(
      {this.object, this.errors, this.message, this.success, this.data});

  UsefullContactsModel.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? new UsefullContactsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Errors {
  int? index;
  String? property;
  String? message;

  Errors({this.index, this.property, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    property = json['property'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['property'] = this.property;
    data['message'] = this.message;
    return data;
  }
}

class UsefullContactsData {
  List<UsefullContacts>? contacts;

  UsefullContactsData({this.contacts});

  UsefullContactsData.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = <UsefullContacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new UsefullContacts.fromJson(v));
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

class UsefullContacts {
  String? id;
  String? description;
  String? number;
  String? status;

  UsefullContacts({this.id, this.description, this.number, this.status});

  UsefullContacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    number = json['number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['number'] = this.number;
    data['status'] = this.status;
    return data;
  }
}
