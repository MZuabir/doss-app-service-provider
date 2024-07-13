class HistoryModel {
  HistoryData? data;
  bool? success;

  HistoryModel({this.data, this.success});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new HistoryData.fromJson(json['data']) : null;
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

class HistoryData {
  List<HistoryItem>? history;

  HistoryData({this.history});

  HistoryData.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <HistoryItem>[];
      json['history'].forEach((v) {
        history!.add(new HistoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryItem {
  String? id;
  String? historyType;
  String? dateTimeClosed;
  String? clientName;
  String? clientUrlPhoto;

  HistoryItem(
      {this.id,
      this.historyType,
      this.dateTimeClosed,
      this.clientName,
      this.clientUrlPhoto});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    historyType = json['historyType'];
    dateTimeClosed = json['dateTimeClosed'];
    clientName = json['clientName'];
    clientUrlPhoto = json['clientUrlPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['historyType'] = this.historyType;
    data['dateTimeClosed'] = this.dateTimeClosed;
    data['clientName'] = this.clientName;
    data['clientUrlPhoto'] = this.clientUrlPhoto;
    return data;
  }
}
