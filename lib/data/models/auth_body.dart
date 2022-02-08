import 'dart:convert';

class AuthBody {
  String email;
  String password;
  AuthBody({
    required this.email,
    required this.password,
  });

  AuthBody copyWith({
    String? email,
    String? password,
  }) {
    return AuthBody(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory AuthBody.fromMap(Map<String, dynamic> map) {
    return AuthBody(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthBody.fromJson(String source) =>
      AuthBody.fromMap(json.decode(source));

  @override
  String toString() => 'AuthBody(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthBody &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
