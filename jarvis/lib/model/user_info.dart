class UserInfo {
  String email;
  String id;
  List<String> roles;
  String username;

  UserInfo({
    this.email = '',
    this.id = '',
    this.roles = const [],
    this.username = '',
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      email: json['email'] ?? '',
      id: json['id'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      username: json['username'] ?? '',
    );
  }
}
