import 'dart:convert';

class Content {
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

  Content({
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

  factory Content.fromMap(Map<String, dynamic> data) => Content(
        id: data['id'] as String?,
        type: data['type'] as String?,
        authorName: data['authorName'] as String?,
        authorBelt: data['authorBelt'] as String?,
        likes: data['likes'] as int?,
        isLikedByLoggedUser: data['isLikedByLoggedUser'] as bool?,
        avgRate: (data['avgRate'] as num?)?.toDouble(),
        title: data['title'] as String?,
        content: data['content'] as String?,
        isRatedByLoggedUser: data['isRatedByLoggedUser'] as bool?,
      );

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
  /// Parses the string and returns the resulting Json object as [Content].
  factory Content.fromJson(String data) {
    return Content.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Content] to a JSON string.
  String toJson() => json.encode(toMap());
}
