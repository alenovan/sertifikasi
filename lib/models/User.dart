class User {
  String? password;
  int? id;
  String? name;

  User({this.password, this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      password: json['password'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}