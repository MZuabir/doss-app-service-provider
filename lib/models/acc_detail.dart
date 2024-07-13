class AccountDetailModel {
  Data? data;
  bool? success;

  AccountDetailModel({this.data, this.success});

  AccountDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  ServiceProvider? serviceProvider;
  Address? address;
  Coverage? coverage;
  FormPayment? formPayment;

  Data({this.serviceProvider, this.address, this.coverage, this.formPayment});

  Data.fromJson(Map<String, dynamic> json) {
    serviceProvider = json['serviceProvider'] != null
        ? new ServiceProvider.fromJson(json['serviceProvider'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    coverage = json['coverage'] != null
        ? new Coverage.fromJson(json['coverage'])
        : null;
    formPayment = json['formPayment'] != null
        ? new FormPayment.fromJson(json['formPayment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceProvider != null) {
      data['serviceProvider'] = this.serviceProvider!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.coverage != null) {
      data['coverage'] = this.coverage!.toJson();
    }
    if (this.formPayment != null) {
      data['formPayment'] = this.formPayment!.toJson();
    }
    return data;
  }
}

class ServiceProvider {
  String? id;
  String? name;
  String? typeDocument;
  String? document;
  String? phone;
  String? photo;

  ServiceProvider(
      {this.id,
      this.name,
      this.typeDocument,
      this.document,
      this.phone,
      this.photo});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeDocument = json['typeDocument'];
    document = json['document'];
    phone = json['phone'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['typeDocument'] = this.typeDocument;
    data['document'] = this.document;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    return data;
  }
}

class Address {
  String? zipCode;
  String? country;
  String? state;
  String? city;
  String? neighborhood;
  String? street;
  String? complement;
  String? number;

  Address(
      {this.zipCode,
      this.country,
      this.state,
      this.city,
      this.neighborhood,
      this.street,
      this.complement,
      this.number});

  Address.fromJson(Map<String, dynamic> json) {
    zipCode = json['zipCode'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    street = json['street'];
    complement = json['complement'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zipCode'] = this.zipCode;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['neighborhood'] = this.neighborhood;
    data['street'] = this.street;
    data['complement'] = this.complement;
    data['number'] = this.number;
    return data;
  }
}

class Coverage {
  num? coverageArea;

  Coverage({this.coverageArea});

  Coverage.fromJson(Map<String, dynamic> json) {
    coverageArea = json['coverageArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coverageArea'] = this.coverageArea;
    return data;
  }
}

class FormPayment {
  String? bankId;
  String? agency;
  String? account;
  List<Plans>? plans;

  FormPayment({this.bankId, this.agency, this.account, this.plans});

  FormPayment.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    agency = json['agency'];
    account = json['account'];
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankId'] = this.bankId;
    data['agency'] = this.agency;
    data['account'] = this.account;
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String? id;
  String? description;
  num? price;

  Plans({this.id, this.description, this.price});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}