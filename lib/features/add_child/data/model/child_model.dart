class ChildModel {
  final String name;
  final String nickName;
  final String age;

  ChildModel({required this.name, required this.nickName, required this.age});

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      name: json['name'],
      nickName: json['nickname'],
      age: json['age'],
    );
  }
}
