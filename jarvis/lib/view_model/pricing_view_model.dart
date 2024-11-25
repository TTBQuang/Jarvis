import 'package:flutter/material.dart';
import 'package:jarvis/model/subscription.dart';
import 'package:jarvis/repository/pricing_repository.dart';

import 'auth_view_model.dart';

class PricingViewModel extends ChangeNotifier {
  final PricingRepository pricingRepository;
  final AuthViewModel authViewModel;
  bool isLoading = false;

  Subscription subscription = Subscription(
      name: SubscriptionType.basic,
      dailyTokens: 30,
      monthlyTokens: 0,
      annuallyTokens: 0);

  PricingViewModel({
    required this.pricingRepository,
    required this.authViewModel,
  });

  Future<void> fetchSubscription() async {
    try {
      isLoading = true;
      notifyListeners();

      subscription =
          await pricingRepository.fetchSubscription(authViewModel.user);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> subscribe() async {
    try {
      isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));
      subscription = Subscription(
          name: SubscriptionType.pro,
          dailyTokens: 30,
          monthlyTokens: 0,
          annuallyTokens: 0);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }
}
