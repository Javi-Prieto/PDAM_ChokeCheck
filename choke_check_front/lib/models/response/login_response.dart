import 'dart:convert';

class LoginResponse {
  String? id;
  String? username;
  String? userBeltColor;
  String? rol;
  String? token;

  LoginResponse({
    this.id,
    this.username,
    this.userBeltColor,
    this.rol,
    this.token,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        id: data['id'] as String?,
        username: data['username'] as String?,
        userBeltColor: data['userBeltColor'] as String?,
        rol: data['rol'] as String?,
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'userBeltColor': userBeltColor,
        'rol': rol,
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
