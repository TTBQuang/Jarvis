import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/user_info.dart';
import 'package:jarvis/model/user_token.dart';

import '../model/user.dart';

class AuthRepository {
  Future<UserToken?> signInWithEmailAndPassword(
      String email, String password) async {
    var headers = {
      'x-jarvis-guid': '',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrlJarvis/api/v1/auth/sign-in'));
    request.body = json.encode({
      "email": email,
      "password": password,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      return UserToken.fromJson(jsonResponse);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    var headers = {
      'x-jarvis-guid': '',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrlJarvis/api/v1/auth/sign-up'));
    request.body = json.encode({
      "email": email,
      "password": password,
      "username": username,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 201) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> signOut(String token) async {
    var headers = {
      'x-jarvis-guid': '',
      'Authorization': 'Bearer $token',
    };
    var request =
        http.Request('GET', Uri.parse('$baseUrlJarvis/api/v1/auth/sign-out'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('sign out success');
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<UserInfo?> getUserInfo(String token) async {
    try {
      var headers = {
        'x-jarvis-guid': '',
        'Authorization': 'Bearer $token',
      };
      var request =
          http.MultipartRequest('GET', Uri.parse('$baseUrlJarvis/api/v1/auth/me'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        return UserInfo.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<String> refreshToken(User user) async {
    var headers = {
      'x-jarvis-guid': user.userUuid,
    };
    var request = http.Request(
      'GET',
      Uri.parse(
          '$baseUrlJarvis/api/v1/auth/refresh?refreshToken=${user.userToken?.refreshToken}'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      final accessToken = data['token']?['accessToken'];
      return accessToken;
    } else {
      print(response.statusCode);
      return '';
    }
  }
}
