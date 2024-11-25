enum SubscriptionType {
  basic('basic'),
  starter('starter'),
  pro('pro');

  final String value;

  const SubscriptionType(this.value);

  static SubscriptionType fromString(String name) {
    for (var type in SubscriptionType.values) {
      if (type.value == name) {
        return type;
      }
    }
    return SubscriptionType.basic;
  }
}

class Subscription {
  int annuallyTokens;
  int dailyTokens;
  int monthlyTokens;
  SubscriptionType name;

  Subscription({
    required this.annuallyTokens,
    required this.dailyTokens,
    required this.monthlyTokens,
    required this.name,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      annuallyTokens: json['annuallyTokens'] ?? 0,
      dailyTokens: json['dailyTokens'] ?? 0,
      monthlyTokens: json['monthlyTokens'] ?? 0,
      name: SubscriptionType.fromString(json['name'] ?? ''),
    );
  }
}