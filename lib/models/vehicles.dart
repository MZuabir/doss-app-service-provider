class VehiclesModel {
  VehiclesDataModel? data;
  bool? success;

  VehiclesModel({this.data, this.success});

  VehiclesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new VehiclesDataModel.fromJson(json['data']) : null;
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

class VehiclesDataModel {
  List<Vehicles>? vehicles;

  VehiclesDataModel({this.vehicles});

  VehiclesDataModel.fromJson(Map<String, dynamic> json) {
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  String? id;
  String? brand;
  String? model;
  String? color;
  String? plate;
  String? photo;
  bool? defaultVehicle;
  String? vehicleType;
  String? created;
  String? updated;

  Vehicles(
      {this.id,
      this.brand,
      this.model,
      this.color,
      this.plate,
      this.photo,
      this.defaultVehicle,
      this.vehicleType,
      this.created,
      this.updated});

  Vehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    plate = json['plate'];
    photo = json['photo'];
    defaultVehicle = json['defaultVehicle'];
    vehicleType = json['vehicleType'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['color'] = this.color;
    data['plate'] = this.plate;
    data['photo'] = this.photo;
    data['defaultVehicle'] = this.defaultVehicle;
    data['vehicleType'] = this.vehicleType;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
