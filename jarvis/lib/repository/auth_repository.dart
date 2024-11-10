import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/user_info.dart';
import 'package:jarvis/model/user_token.dart';

class AuthRepository {
  Future<UserToken?> signInWithEmailAndPassword(
      String email, String password) async {
    var headers = {
      'x-jarvis-guid': '',
      'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrl/api/v1/auth/sign-in'));
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
      throw Exception('${response.reasonPhrase}');
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    var headers = {
      'x-jarvis-guid': '',
      'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrl/api/v1/auth/sign-up'));
    request.body = json.encode({
      "email": email,
      "password": password,
      "username": username,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 201) {
      throw Exception('${response.reasonPhrase}');
    }
  }

  Future<void> signOut(String token) async {
    var headers = {
      'x-jarvis-guid': '',
      'Authorization': 'Bearer $token',
      'User-Agent': 'Apidog/1.0.0 (https://apidog.com)'
    };
    var request =
        http.Request('GET', Uri.parse('$baseUrl/api/v1/auth/sign-out'));

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
        'User-Agent': 'Apidog/1.0.0 (https://apidog.com)'
      };
      var request =
          http.MultipartRequest('GET', Uri.parse('$baseUrl/api/v1/auth/me'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        return UserInfo.fromJson(jsonResponse);
      } else {
        throw Exception('${response.reasonPhrase}');
      }
    } catch (e) {
      print(e);
      throw Exception('$e');
    }
  }
}
