import '../../../../core/utils/enums.dart';

class UserUpdateUserReq {
  String? firstName;
  String? lastName;

  /// User role assigned to the user.
  ///
  /// Enum: "admin" "member" "developer"
  UserRole? role;

  /// The api token of the User.
  String? apiToken;

  /// An optional set of key-value pairs with additional information.
  Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (firstName != null) {
      data['first_name'] = firstName;
    }

    if (lastName != null) {
      data['last_name'] = lastName;
    }

    if (role != null) {
      data['role'] = role.toString();
    }

    if (apiToken != null) {
      data['api_token'] = apiToken;
    }

    if (metadata != null) {
      data['metadata'] = metadata;
    }
    return data;
  }
}
