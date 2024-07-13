class ChatModel {
  ChatData? data;
  bool? success;

  ChatModel({this.data, this.success});

  ChatModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  ChatData.fromJson(json['data']) : null;
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

class ChatData {
  int? page;
  int? total;
  String? photoUrl;
  List<Chats>? chats;

  ChatData({this.page, this.total, this.photoUrl, this.chats});

  ChatData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    total = json['total'];
    photoUrl = json['photoUrl'];
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total'] = this.total;
    data['photoUrl'] = this.photoUrl;
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String? id;
  String? userId;
  String? message;
  String? photoUrl;
  String? audioUrl;
  String? when;

  Chats(
      {this.id,
      this.userId,
      this.message,
      this.photoUrl,
      this.audioUrl,
      this.when});

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    message = json['message'];
    photoUrl = json['photoUrl'];
    audioUrl = json['audioUrl'];
    when = json['when'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['message'] = this.message;
    data['photoUrl'] = this.photoUrl;
    data['audioUrl'] = this.audioUrl;
    data['when'] = this.when;
    return data;
  }
}
