class ResidentialDetailModel {
  ResidentialDataModel? data;
  bool? success;

  ResidentialDetailModel({this.data, this.success});

  ResidentialDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ResidentialDataModel.fromJson(json['data']) : null;
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

class ResidentialDataModel {
  Address? address;
  Vehicle? vehicle;

  ResidentialDataModel({this.address, this.vehicle});

  ResidentialDataModel.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    vehicle =
        json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    return data;
  }
}

class Address {
  String? country;
  String? state;
  String? city;
  String? neighborhood;
  String? street;
  String? number;
  String? zipCode;
  String? complement;
  double? latitude;
  double? longitude;

  Address(
      {this.country,
      this.state,
      this.city,
      this.neighborhood,
      this.street,
      this.number,
      this.zipCode,
      this.complement,
      this.latitude,
      this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    street = json['street'];
    number = json['number'];
    zipCode = json['zipCode'];
    complement = json['complement'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['neighborhood'] = this.neighborhood;
    data['street'] = this.street;
    data['number'] = this.number;
    data['zipCode'] = this.zipCode;
    data['complement'] = this.complement;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Vehicle {
  String? brand;
  String? model;
  String? color;
  String? plate;
  String? photoUrl;
  String? vehicleType;

  Vehicle(
      {this.brand,
      this.model,
      this.color,
      this.plate,
      this.photoUrl,
      this.vehicleType});

  Vehicle.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    plate = json['plate'];
    photoUrl = json['photoUrl'];
    vehicleType = json['vehicleType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['color'] = this.color;
    data['plate'] = this.plate;
    data['photoUrl'] = this.photoUrl;
    data['vehicleType'] = this.vehicleType;
    return data;
  }
}
