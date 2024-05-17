import 'dart:convert';

import 'user_best_publisher_list.dart';

class UserBestAppliers {
	int? totalApplies;
	List<UserBestPublisherList>? userBestPublisherList;

	UserBestAppliers({this.totalApplies, this.userBestPublisherList});

	factory UserBestAppliers.fromMap(Map<String, dynamic> data) {
		return UserBestAppliers(
			totalApplies: data['totalApplies'] as int?,
			userBestPublisherList: (data['userBestPublisherList'] as List<dynamic>?)
						?.map((e) => UserBestPublisherList.fromMap(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toMap() => {
				'totalApplies': totalApplies,
				'userBestPublisherList': userBestPublisherList?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserBestAppliers].
	factory UserBestAppliers.fromJson(String data) {
		return UserBestAppliers.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [UserBestAppliers] to a JSON string.
	String toJson() => json.encode(toMap());
}
