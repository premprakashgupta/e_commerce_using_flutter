class UserModel {
  int id;
  String email;
  List<dynamic> address;
  String name;
  String role;
  String avatar;

  UserModel(
      {required this.address,
      required this.id,
      required this.email,
      required this.name,
      required this.role,
      required this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      address: json['address'],
      name: json['name'],
      role: json['role'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['address'] = address;
    data['name'] = name;
    data['role'] = role;
    data['avatar'] = avatar;
    return data;
  }
}
