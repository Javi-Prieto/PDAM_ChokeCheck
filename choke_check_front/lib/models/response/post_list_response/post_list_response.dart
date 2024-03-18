import 'dart:convert';

import 'content.dart';

class PostListResponse {
  List<Content>? content;
  int? size;
  int? totalElements;
  int? pageNumber;
  bool? first;
  bool? last;

  PostListResponse({
    this.content,
    this.size,
    this.totalElements,
    this.pageNumber,
    this.first,
    this.last,
  });

  factory PostListResponse.fromMap(Map<String, dynamic> data) {
    return PostListResponse(
      content: (data['content'] as List<dynamic>?)
          ?.map((e) => Content.fromMap(e as Map<String, dynamic>))
          .toList(),
      size: data['size'] as int?,
      totalElements: data['totalElements'] as int?,
      pageNumber: data['pageNumber'] as int?,
      first: data['first'] as bool?,
      last: data['last'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'content': content?.map((e) => e.toMap()).toList(),
        'size': size,
        'totalElements': totalElements,
        'pageNumber': pageNumber,
        'first': first,
        'last': last,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PostListResponse].
  factory PostListResponse.fromJson(String data) {
    return PostListResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PostListResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
