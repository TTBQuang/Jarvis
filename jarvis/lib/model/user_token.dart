class UserToken {
  String accessToken;
  String refreshToken;

  UserToken({
    this.accessToken = '',
    this.refreshToken = '',
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    final tokenData = json['token'] ?? {};

    return UserToken(
      accessToken: tokenData['accessToken'] ?? '',
      refreshToken: tokenData['refreshToken'] ?? '',
    );
  }
}
