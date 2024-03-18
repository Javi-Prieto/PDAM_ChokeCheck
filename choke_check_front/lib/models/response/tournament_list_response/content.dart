import 'dart:convert';

class Content {
  String? id;
  String? title;
  String? date;
  double? cost;
  int? participants;
  int? applied;
  String? higherBelt;
  double? prize;
  String? author;
  int? minWeight;
  bool? isAppliedByLoggedUser;
  int? maxWeight;

  Content({
    this.id,
    this.title,
    this.date,
    this.cost,
    this.participants,
    this.applied,
    this.higherBelt,
    this.prize,
    this.author,
    this.minWeight,
    this.isAppliedByLoggedUser,
    this.maxWeight,
  });

  factory Content.fromMap(Map<String, dynamic> data) => Content(
        id: data['id'] as String?,
        title: data['title'] as String?,
        date: data['date'] as String?,
        cost: data['cost'] as double?,
        participants: data['participants'] as int?,
        applied: data['applied'] as int?,
        higherBelt: data['higherBelt'] as String?,
        prize: data['prize'] as double?,
        author: data['author'] as String?,
        minWeight: data['minWeight'] as int?,
        isAppliedByLoggedUser: data['isAppliedByLoggedUser'] as bool?,
        maxWeight: data['maxWeight'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'date': date,
        'cost': cost,
        'participants': participants,
        'applied': applied,
        'higherBelt': higherBelt,
        'prize': prize,
        'author': author,
        'minWeight': minWeight,
        'isAppliedByLoggedUser': isAppliedByLoggedUser,
        'maxWeight': maxWeight,
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
