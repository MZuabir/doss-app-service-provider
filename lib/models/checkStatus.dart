class CheckStatusModel {
  Data? data; // Make Data nullable

  bool get completedRegistration => data?.completedRegistration ?? false;

  CheckStatusModel({
    this.data,
  });

  factory CheckStatusModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle the case when the response body is null
      return CheckStatusModel();
    }
    return CheckStatusModel(
      data: json.containsKey('data') ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  bool completedRegistration;

  Data({
    required this.completedRegistration,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      completedRegistration: json['completedRegistration'],
    );
  }
}
