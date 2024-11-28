class UserToken {
  TokenJarvis tokenJarvis;
  TokenKb tokenKb;

  UserToken({
    required this.tokenJarvis,
    required this.tokenKb,
  });

  UserToken copyWith({
    TokenJarvis? tokenJarvis,
    TokenKb? tokenKb,
  }) {
    return UserToken(
      tokenJarvis: tokenJarvis ?? this.tokenJarvis,
      tokenKb: tokenKb ?? this.tokenKb,
    );
  }
}

class TokenJarvis {
  String accessToken;
  String refreshToken;

  TokenJarvis(this.accessToken, this.refreshToken);

  factory TokenJarvis.fromJson(Map<String, dynamic> json) {
    final token = json['token'];
    return TokenJarvis(
      token['accessToken'] ?? '',
      token['refreshToken'] ?? '',
    );
  }
}

class TokenKb {
  String accessToken;
  String refreshToken;

  TokenKb(this.accessToken, this.refreshToken);

  factory TokenKb.fromJson(Map<String, dynamic> json) {
    final token = json['token'];
    return TokenKb(
      token['accessToken'] ?? '',
      token['refreshToken'] ?? '',
    );
  }
}
