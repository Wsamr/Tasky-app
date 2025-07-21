// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String userName;
  final String email;
  final String password;
  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "password": password,
    };
  }
}
