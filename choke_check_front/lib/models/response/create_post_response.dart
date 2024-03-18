import 'dart:convert';

class CreatePostResponse {
  String? id;
  String? type;
  String? authorName;
  String? authorBelt;
  int? likes;
  bool? isLikedByLoggedUser;
  double? avgRate;
  String? title;
  String? content;
  bool? isRatedByLoggedUser;

  CreatePostResponse({
    this.id,
    this.type,
    this.authorName,
    this.authorBelt,
    this.likes,
    this.isLikedByLoggedUser,
    this.avgRate,
    this.title,
    this.content,
    this.isRatedByLoggedUser,
  });

  factory CreatePostResponse.fromMap(Map<String, dynamic> data) {
    return CreatePostResponse(
      id: data['id'] as String?,
      type: data['type'] as String?,
      authorName: data['authorName'] as String?,
      authorBelt: data['authorBelt'] as String?,
      likes: data['likes'] as int?,
      isLikedByLoggedUser: data['isLikedByLoggedUser'] as bool?,
      avgRate: data['avgRate'] as double?,
      title: data['title'] as String?,
      content: data['content'] as String?,
      isRatedByLoggedUser: data['isRatedByLoggedUser'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'authorName': authorName,
        'authorBelt': authorBelt,
        'likes': likes,
        'isLikedByLoggedUser': isLikedByLoggedUser,
        'avgRate': avgRate,
        'title': title,
        'content': content,
        'isRatedByLoggedUser': isRatedByLoggedUser,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreatePostResponse].
  factory CreatePostResponse.fromJson(String data) {
    return CreatePostResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreatePostResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
