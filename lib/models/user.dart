class User {
  String email;
  String name;
  String password;
  String username;

  User({
    required this.email,
    required this.name,
    required this.password,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['mail'],
      name: json['name'],
      password: json['pass'].toString(),
      username: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mail': email,
      'name': name,
      'pass': password,
      'user': username,
    };
  }
}
