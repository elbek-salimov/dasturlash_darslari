class UserModel {
  final String username;
  final String email;
  final String userId;
  final String authUid;
  final String password;

  UserModel({
    required this.email,
    required this.userId,
    required this.username,
    required this.authUid,
    required this.password,
  });

  UserModel copyWith({
    String? username,
    String? phoneNumber,
    String? userId,
    String? authUid,
    String? password,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: phoneNumber ?? this.email,
      authUid: authUid ?? this.authUid,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "email": email,
    "authUid": authUid,
  };

  Map<String, dynamic> toJsonForUpdate() => {
    "username": username,
    "email": email,
    "authUid": authUid,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"] as String? ?? "",
      userId: json["userId"] as String? ?? "",
      username: json["username"] as String? ?? "",
      authUid: json["authUid"] as String? ?? "",
      password: json["password"] as String? ?? "",
    );
  }

  static UserModel initial() => UserModel(
    email: "",
    userId: "",
    username: "",
    authUid: "",
    password: '',
  );
}
