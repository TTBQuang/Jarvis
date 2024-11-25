import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/subscription.dart';

import '../model/user.dart';

class PricingRepository {
  Future<Subscription> fetchSubscription(User user) async {
    var headers = {
      'x-jarvis-guid': user.userToken?.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.accessToken}',
    };

    var request = http.Request('GET', Uri.parse('$baseUrlJarvis/api/v1/subscriptions/me'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> json = jsonDecode(responseBody);
      return Subscription.fromJson(json);
    } else {
      print('Error: ${response.statusCode}');
      throw Exception(response.reasonPhrase);
    }
  }
}
