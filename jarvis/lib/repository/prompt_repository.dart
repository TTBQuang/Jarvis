import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/prompt.dart';
import 'package:jarvis/model/prompt_list.dart';
import 'package:jarvis/model/user.dart';

class PromptRepository {
  Future<PromptList> fetchPrompts({
    String? query,
    int? offset,
    int? limit,
    String? category,
    bool? isFavorite,
    bool? isPublic,
    required User user,
  }) async {
    var headers = {
      'x-jarvis-guid': user.userToken?.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.accessToken}',
    };

    Uri uri = Uri.parse('$baseUrl/api/v1/prompts').replace(
      queryParameters: {
        if (query != null) 'query': query,
        if (offset != null) 'offset': offset.toString(),
        if (limit != null) 'limit': limit.toString(),
        if (category != null) 'category': category,
        if (isFavorite != null) 'isFavorite': isFavorite.toString(),
        if (isPublic != null) 'isPublic': isPublic.toString(),
      },
    );

    var request = http.Request('GET', uri);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return PromptList.fromJson(jsonData);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addPromptToFavorites({
    required String promptId,
    required User user,
  }) async {
    var headers = {
      'x-jarvis-guid': user.userToken?.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.accessToken}',
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl/api/v1/prompts/$promptId/favorite'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      print(response.statusCode);
    }
  }

  Future<void> removePromptFromFavorites({
    required String promptId,
    required User user,
  }) async {
    var headers = {
      'x-jarvis-guid': user.userToken?.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.accessToken}',
    };
    var request = http.Request(
        'DELETE', Uri.parse('$baseUrl/api/v1/prompts/$promptId/favorite'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      print(response.statusCode);
    }
  }

  Future<void> deletePrompt({
    required String promptId,
    required User user,
  }) async {
    var headers = {
      'x-jarvis-guid': user.userToken?.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.accessToken}',
    };
    var request =
        http.Request('DELETE', Uri.parse('$baseUrl/api/v1/prompts/$promptId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> updatePrompt({
    required User user,
    required Prompt prompt,
  }) async {
    var headers = {
      'x-jarvis-guid': user.userToken?.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.accessToken}',
      'Content-Type': 'application/json'
    };

    var request = http.Request(
        'PATCH', Uri.parse('$baseUrl/api/v1/prompts/${prompt.id}'));

    request.body = json.encode({
      "title": prompt.title,
      "content": prompt.content,
      "description": prompt.description,
      "category": prompt.category.apiValue,
      "language": prompt.language.englishName,
      "isPublic": false,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      print(response.reasonPhrase);
    }
  }
}
