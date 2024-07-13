// To parse this JSON data, do
//
//     final verificationAllModel = verificationAllModelFromJson(jsonString);

import 'dart:convert';

VerificationAllModel verificationAllModelFromJson(String str) =>
    VerificationAllModel.fromJson(json.decode(str));

String verificationAllModelToJson(VerificationAllModel data) =>
    json.encode(data.toJson());

class VerificationAllModel {
  String? object;
  List<Error>? errors;
  String? message;
  bool? success;
  Data? data;

  VerificationAllModel({
    this.object,
    this.errors,
    this.message,
    this.success,
    this.data,
  });

  factory VerificationAllModel.fromJson(Map<String, dynamic> json) =>
      VerificationAllModel(
        object: json["object"],
        errors: json["errors"] == null
            ? []
            : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "errors": errors == null
            ? []
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  List<Verification>? verifications;

  Data({
    this.verifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        verifications: json["verifications"] == null
            ? []
            : List<Verification>.from(
                json["verifications"]!.map((x) => Verification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "verifications": verifications == null
            ? []
            : List<dynamic>.from(verifications!.map((x) => x.toJson())),
      };
}

class Verification {
  String? id;
  String? message;
  DateTime? when;
  Address? address;
  Residential? residential;

  Verification({
    this.id,
    this.message,
    this.when,
    this.address,
    this.residential,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        id: json["id"],
        message: json["message"],
        when: json["when"] == null ? null : DateTime.parse(json["when"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        residential: json["residential"] == null
            ? null
            : Residential.fromJson(json["residential"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "when": when?.toIso8601String(),
        "address": address?.toJson(),
        "residential": residential?.toJson(),
      };
}

class Address {
  String? state;
  String? city;
  String? street;
  String? zipCode;
  String? number;
  double? lat, lng;
  Address({
    this.state,
    this.city,
    this.lat,
    this.lng,
    this.street,
    this.zipCode,
    this.number,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        state: json["state"],
        city: json["city"],
        lat: json['latitude'],
        lng: json['longitude'],
        street: json["street"],
        zipCode: json["zipCode"].toString(),
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "city": city,
        'longitude': lng,
        'latitude': lat,
        "street": street,
        "zipCode": zipCode,
        "number": number,
      };
}

class Residential {
  String? name;
  String? photo;

  Residential({
    this.name,
    this.photo,
  });

  factory Residential.fromJson(Map<String, dynamic> json) => Residential(
        name: json["name"],
        photo: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "photoUrl": photo,
      };
}

class Error {
  int? index;
  String? property;
  String? message;

  Error({
    this.index,
    this.property,
    this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        index: json["index"],
        property: json["property"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "property": property,
        "message": message,
      };
}
