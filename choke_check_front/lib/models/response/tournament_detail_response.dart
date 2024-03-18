import 'dart:convert';

class TournamentDetailResponse {
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
  String? content;
  double? lat;
  double? lon;
  String? city;

  TournamentDetailResponse({
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
    this.content,
    this.lat,
    this.lon,
    this.city,
  });

  factory TournamentDetailResponse.fromMap(Map<String, dynamic> data) {
    return TournamentDetailResponse(
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
      content: data['content'] as String?,
      lat: (data['lat'] as num?)?.toDouble(),
      lon: (data['lon'] as num?)?.toDouble(),
      city: data['city'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
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
        'content': content,
        'lat': lat,
        'lon': lon,
        'city': city,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TournamentDetailResponse].
  factory TournamentDetailResponse.fromJson(String data) {
    return TournamentDetailResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TournamentDetailResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
