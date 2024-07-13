
import 'dart:convert';

UserModel userModelFromJson(String? str) => UserModel.fromJson(json.decode(str!));

String? userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? ver;
  String? iss;
  String? sub;
  String? aud;
  int? exp;
  String? nonce;
  int? iat;
  int? authTime;
  String? idpAccessToken;
  String? firstName;
  String? lastName;
  String? name;
  String? idp;
  String? oid;
  List<String?>? emails;
  String? tfp;
  String? atHash;
  int? nbf;

  UserModel({
    this.ver,
    this.iss,
    this.sub,
    this.aud,
    this.exp,
    this.nonce,
    this.iat,
    this.authTime,
    this.idpAccessToken,
    this.firstName,
    this.lastName,
    this.name,
    this.idp,
    this.oid,
    this.emails,
    this.tfp,
    this.atHash,
    this.nbf,
  });

  factory UserModel.fromJson(Map<String?, dynamic> json) => UserModel(
    ver: json["ver"],
    iss: json["iss"],
    sub: json["sub"],
    aud: json["aud"],
    exp: json["exp"],
    nonce: json["nonce"],
    iat: json["iat"],
    authTime: json["auth_time"],
    idpAccessToken: json["idp_access_token"],
    firstName: json["given_name"],
    lastName: json["family_name"],
    name: json["name"],
    idp: json["idp"],
    oid: json["oid"],
    emails: List<String?>.from(json["emails"].map((x) => x)),
    tfp: json["tfp"],
    atHash: json["at_hash"],
    nbf: json["nbf"],
  );

  Map<String?, dynamic> toJson() => {
    "ver": ver,
    "iss": iss,
    "sub": sub,
    "aud": aud,
    "exp": exp,
    "nonce": nonce,
    "iat": iat,
    "auth_time": authTime,
    "idp_access_token": idpAccessToken,
    "given_name": firstName,
    "family_name": lastName,
    "name": name,
    "idp": idp,
    "oid": oid,
    "emails": List<dynamic>.from(emails!.map((x) => x)),
    "tfp": tfp,
    "at_hash": atHash,
    "nbf": nbf,
  };
}