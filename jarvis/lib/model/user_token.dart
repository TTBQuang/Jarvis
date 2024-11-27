class UserToken {
  String accessTokenJarvis;
  String refreshTokenJarvis;

  UserToken({
    this.accessTokenJarvis = '',
    this.refreshTokenJarvis = '',
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    final tokenData = json['token'] ?? {};

    return UserToken(
      accessTokenJarvis: tokenData['accessToken'] ?? '',
      refreshTokenJarvis: tokenData['refreshToken'] ?? '',
    );
  }
}
