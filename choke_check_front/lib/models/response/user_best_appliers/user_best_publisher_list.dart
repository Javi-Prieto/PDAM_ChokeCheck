import 'dart:convert';

class UserBestPublisherList {
	String? name;
	String? surname;
	String? username;
	String? belt;
	int? postPublished;

	UserBestPublisherList({
		this.name, 
		this.surname, 
		this.username, 
		this.belt, 
		this.postPublished, 
	});

	factory UserBestPublisherList.fromMap(Map<String, dynamic> data) {
		return UserBestPublisherList(
			name: data['name'] as String?,
			surname: data['surname'] as String?,
			username: data['username'] as String?,
			belt: data['belt'] as String?,
			postPublished: data['postPublished'] as int?,
		);
	}



	Map<String, dynamic> toMap() => {
				'name': name,
				'surname': surname,
				'username': username,
				'belt': belt,
				'postPublished': postPublished,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserBestPublisherList].
	factory UserBestPublisherList.fromJson(String data) {
		return UserBestPublisherList.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [UserBestPublisherList] to a JSON string.
	String toJson() => json.encode(toMap());
}
