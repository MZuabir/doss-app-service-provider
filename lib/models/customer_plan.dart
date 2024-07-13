class CustomerPlanModel {
  String? object;
  List<Errors>? errors;
  String? message;
  bool? success;
  List<CustomerPlanData>? data;

  CustomerPlanModel(
      {this.object, this.errors, this.message, this.success, this.data});

  CustomerPlanModel.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <CustomerPlanData>[];
      json['data'].forEach((v) {
        data!.add(new CustomerPlanData.fromJson(v));
      });
    }
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class CustomerPlanData {
  String? id;
  String? description;
  num? price;
  String? planStatus;
  String? created;
  String? updated;

  CustomerPlanData(
      {this.id,
      this.description,
      this.price,
      this.planStatus,
      this.created,
      this.updated});

  CustomerPlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    price = json['price'];
    planStatus = json['planStatus'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['price'] = this.price;
    data['planStatus'] = this.planStatus;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
