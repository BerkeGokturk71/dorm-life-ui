class LoanModel {
  String? userToken;
  String? machineType;
  String? machineCount;

  LoanModel(
      {required this.userToken,
      required this.machineType,
      required this.machineCount});

  LoanModel.fromJson(Map<String, dynamic> json) {
    userToken = json['user_token'];
    machineType = json['machine_type'];
    machineCount = json['machine_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_token'] = this.userToken;
    data['machine_type'] = this.machineType;
    data['machine_count'] = this.machineCount;
    return data;
  }
}
