class ChildModel {
  final String name;
  final String nickName;
  final String age;

  ChildModel(
      {
      required this.name,
      required this.nickName,
      required this.age});

  factory ChildModel.formJson(Map<String, dynamic> json) {
    return ChildModel(
      name: json['name'],
      nickName: json['nickName'],
      age: json['age'],
    );
  }
}
