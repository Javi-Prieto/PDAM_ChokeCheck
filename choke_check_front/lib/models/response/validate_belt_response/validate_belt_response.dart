import 'dart:convert';

class ValidateBeltResponse {
	String? beltColor;

	ValidateBeltResponse({this.beltColor});

	factory ValidateBeltResponse.fromMap(Map<String, dynamic> data) {
		return ValidateBeltResponse(
			beltColor: data['belt_color'] as String?,
		);
	}



	Map<String, dynamic> toMap() => {
				'belt_color': beltColor,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ValidateBeltResponse].
	factory ValidateBeltResponse.fromJson(String data) {
		return ValidateBeltResponse.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ValidateBeltResponse] to a JSON string.
	String toJson() => json.encode(toMap());
}
