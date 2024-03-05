class AutismModel {
  final String response;
  final bool result;
  final double precentage;

  AutismModel(
      {required this.response, required this.result, required this.precentage});

  factory AutismModel.fromJson(Map<String, dynamic> json) {
    return AutismModel(
      response: json['response'] ?? '',
      result: json['result'] ?? false,
      precentage: json['precentage'] ?? 0,
    );
  }
}
