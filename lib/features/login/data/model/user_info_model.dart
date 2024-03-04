class UserInfoModel {
  final String id;
  final String email;

  UserInfoModel({required this.id, required this.email});

  factory UserInfoModel.formJson(Map<String, dynamic> json) {
    return UserInfoModel(id: json['id'], email: json['email']);
  }
}
