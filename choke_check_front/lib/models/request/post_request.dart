class PostRequest {
  final String type, title, content;

  PostRequest({required this.type, required this.title, required this.content});

  Map<String, dynamic> toMap() =>
      {'type': type, 'title': title, 'content': content};
}
