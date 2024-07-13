import 'dart:convert';

class AlertModel {
  Data data;
  bool success;

  AlertModel({
    required this.data,
    required this.success,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    Data data = Data(
      messages: (json['data']['messages'] as List<dynamic>)
          .map((messageJson) => Message(
        description: messageJson['description'],
        created: messageJson['created'],
      ))
          .toList(),
    );

    return AlertModel(
      data: data,
      success: json['success'],
    );
  }
}

class Data {
  List<Message> messages;

  Data({
    required this.messages,
  });
}

class Message {
  String description;
  String created;

  Message({
    required this.description,
    required this.created,
  });
}

AlertModel parseApiResponse(String apiResponse) {
  final Map<String, dynamic> json = jsonDecode(apiResponse);

  return AlertModel.fromJson(json);
}
