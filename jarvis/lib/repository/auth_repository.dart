import 'dart:convert';
import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/user_info.dart';
import 'package:jarvis/model/user_token.dart';

import '../model/user.dart';

class AuthRepository {
  Future<TokenJarvis?> signInWithEmailAndPassword(
      String email, String password) async {
    var headers = {'x-jarvis-guid': '', 'Content-Type': 'application/json'};
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
      return TokenJarvis.fromJson(jsonResponse);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    var headers = {'x-jarvis-guid': '', 'Content-Type': 'application/json'};
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
      var request = http.MultipartRequest(
          'GET', Uri.parse('$baseUrlJarvis/api/v1/auth/me'));

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
          '$baseUrlJarvis/api/v1/auth/refresh?refreshToken=${user.userToken?.tokenJarvis.refreshToken}'),
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

  Future<TokenKb?> signInFromExternalClient(String accessTokenJarvis) async {
    var headers = {'x-jarvis-guid': '', 'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('$baseUrlKb/kb-core/v1/auth/external-sign-in'));
    request.body = json.encode({"token": accessTokenJarvis});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      return TokenKb.fromJson(jsonResponse);
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      //clientId: '599361404647-e74vpq6s2ab8q6r275s12sdhr36enq5l.apps.googleusercontent.com',
      serverClientId: '190440784483-jrpsu3r7snkb3imtrp4oga57t48dlfcd.apps.googleusercontent.com',
    );
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      print('googleUser == null');
      return;
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    log('access: ${googleAuth.accessToken}');
    log('id: ${googleAuth.idToken}');

    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('$baseUrlJarvis/api/v1/auth/google-sign-in'));
    request.body = json.encode({"token": googleAuth.idToken});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }
}
