import 'dart:convert';

import 'post.dart';

class UserDetailResponse {
  String? name;
  String? surname;
  String? username;
  String? belt;
  int? age;
  int? weight;
  int? height;
  int? sex;
  String? email;
  List<Post>? posts;

  UserDetailResponse({
    this.name,
    this.surname,
    this.username,
    this.belt,
    this.age,
    this.weight,
    this.height,
    this.sex,
    this.email,
    this.posts,
  });

  factory UserDetailResponse.fromMap(Map<String, dynamic> data) {
    return UserDetailResponse(
      name: data['name'] as String?,
      surname: data['surname'] as String?,
      username: data['username'] as String?,
      belt: data['belt'] as String?,
      age: data['age'] as int?,
      weight: data['weight'] as int?,
      height: data['height'] as int?,
      sex: data['sex'] as int?,
      email: data['email'] as String?,
      posts: (data['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'surname': surname,
        'username': username,
        'belt': belt,
        'age': age,
        'weight': weight,
        'height': height,
        'sex': sex,
        'email': email,
        'posts': posts?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserDetailResponse].
  factory UserDetailResponse.fromJson(String data) {
    return UserDetailResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserDetailResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
