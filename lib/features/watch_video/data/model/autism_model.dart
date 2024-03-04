class AutismModel {
  final String response;
  final bool result;
  final double percentage;

  AutismModel(
      {required this.response, required this.result, required this.percentage});

  factory AutismModel.fromJson(Map<String, dynamic> json) {
    return AutismModel(
      response: json['response'],
      result: json['result'],
      percentage: json['percentage'],
    );
  }
}
