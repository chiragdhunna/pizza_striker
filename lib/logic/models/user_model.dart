class User {
  final int? id;
  final String name;
  final int strikes;
  final String username;
  final String password;
  final String email;

  const User(
      {this.id,
      required this.name,
      required this.strikes,
      required this.email,
      required this.password,
      required this.username,
      zz});

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'strikes': strikes,
        'email': email,
        'password': password,
        'username': username,
      };

  User copyWith({
    required int id,
    required String name,
    required int strikes,
    required String email,
    required String username,
    required String password,
  }) =>
      User(
          id: this.id,
          name: this.name,
          strikes: this.strikes,
          username: this.username,
          password: this.password,
          email: this.email);

  factory User.fromJson(Map<String, Object?> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        strikes: json['strikes'] as int,
        email: json['email'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
      );
}
