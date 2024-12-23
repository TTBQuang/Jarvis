class SendEmailResponse {
  String email;
  int remainingUsage;

  SendEmailResponse({
    required this.remainingUsage,
    required this.email,
  });

  factory SendEmailResponse.fromJson(Map<String, dynamic> json) {
    return SendEmailResponse(
      remainingUsage: json['remainingUsage'] ?? 0,
      email: json['email'] ?? '',
    );
  }
}
