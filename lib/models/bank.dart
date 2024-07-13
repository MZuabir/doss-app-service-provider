class BankModel {
  Data data;
  bool success;

  BankModel({
    required this.data,
    required this.success,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      data: Data.fromJson(json['data']),
      success: json['success'],
    );
  }
}

class Data {
  List<Bank> banks;

  Data({
    required this.banks,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    List<dynamic> bankList = json['banks'];
    List<Bank> banks = bankList.map((item) => Bank.fromJson(item)).toList();

    return Data(
      banks: banks,
    );
  }
}

class Bank {
  String id;
  String name;
  String bankStatus;

  Bank({
    required this.id,
    required this.name,
    required this.bankStatus,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      bankStatus: json['bankStatus'],
    );
  }
}
