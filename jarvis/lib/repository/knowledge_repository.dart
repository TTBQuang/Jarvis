import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:jarvis/model/knowledge_list.dart';
import 'package:jarvis/model/knowledge_unit.dart';
import 'package:jarvis/model/knowledge_unit_list.dart';
import 'package:mime/mime.dart';

import '../model/user.dart';

class KnowledgeRepository {
  Future<Knowledge> createKnowledge(
      {required User user,
      required String name,
      required String description}) async {
    var headers = {
      'x-jarvis-guid':
          user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrlKb/kb-core/v1/knowledge'));
    request.body = json.encode({
      "knowledgeName": name,
      "description": description,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return Knowledge.fromJson(jsonData);
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<KnowledgeList> fetchKnowledgeList(
      {required User user,
      required int offset,
      required int limit,
      required String query}) async {
    var headers = {
      'x-jarvis-guid':
          user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
    };
    final uri = Uri.parse('$baseUrlKb/kb-core/v1/knowledge').replace(
      queryParameters: {
        'q': query,
        'order': 'DESC',
        'order_field': 'createdAt',
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );
    var request = http.Request('GET', uri);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return KnowledgeList.fromJson(jsonData);
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteKnowledge({required User user, required String id}) async {
    var headers = {
      'x-jarvis-guid':
          user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
    };
    var request = http.Request(
        'DELETE', Uri.parse('$baseUrlKb/kb-core/v1/knowledge/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<KnowledgeUnitList> fetchKnowledgeUnitList(
      {required User user,
      required int offset,
      required int limit,
      required String knowledgeId}) async {
    var headers = {
      'x-jarvis-guid':
          user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
    };

    var uri = Uri.parse('$baseUrlKb/kb-core/v1/knowledge/$knowledgeId/units')
        .replace(queryParameters: {
      'order': 'DESC',
      'order_field': 'createdAt',
      'offset': '0',
      'limit': '20',
    });
    var request = http.Request('GET', uri);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return KnowledgeUnitList.fromJson(jsonData);
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<KnowledgeUnit> uploadLocalFile(
      {required User user,
      required String path,
      required String knowledgeId}) async {
    var headers = {
      'x-jarvis-guid':
          user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
      'Content-Type': 'multipart/form-data',
    };

    final uri =
        Uri.parse('$baseUrlKb/kb-core/v1/knowledge/$knowledgeId/local-file');

    final mimeType = lookupMimeType(path) ?? 'application/octet-stream';

    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        path,
        contentType: MediaType.parse(mimeType),
      ));

    request.headers.addAll(headers);

    final response = await request.send();
    if (response.statusCode == 201) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return KnowledgeUnit.fromJson(jsonData);
    } else {
      String responseBody = await response.stream.bytesToString();
      print('File upload failed: ${response.statusCode}');
      print('Response body: $responseBody');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<KnowledgeUnit> uploadWebsite(
      {required User user,
      required String webUrl,
      required String unitName,
      required String knowledgeId}) async {
    var headers = {
      'x-jarvis-guid':
          user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrlKb/kb-core/v1/knowledge/$knowledgeId/web'));
    request.body = json.encode({"unitName": unitName, "webUrl": webUrl});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return KnowledgeUnit.fromJson(jsonData);
    } else {
      String responseBody = await response.stream.bytesToString();
      print('File upload failed: ${response.statusCode}');
      print('Response body: $responseBody');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<KnowledgeUnit> uploadDataFromSlack(
      {required User user,
        required String name,
        required String workspace,
        required String token,
        required String knowledgeId}
      ) async {
    var headers = {
      'x-jarvis-guid':
      user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('$baseUrlKb/kb-core/v1/knowledge/$knowledgeId/slack'));
    request.body = json.encode({
      "unitName": name,
      "slackWorkspace": workspace,
      "slackBotToken": token,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return KnowledgeUnit.fromJson(jsonData);
    } else {
      String responseBody = await response.stream.bytesToString();
      print('File upload failed: ${response.statusCode}');
      print('Response body: $responseBody');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<KnowledgeUnit> uploadDataFromConfluence(
      {required User user,
        required String name,
        required String wikiPageUrl,
        required String username,
        required String accessToken,
        required String knowledgeId}
      ) async {
    var headers = {
      'x-jarvis-guid':
      user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('$baseUrlKb/kb-core/v1/knowledge/$knowledgeId/confluence'));
    request.body = json.encode({
      "unitName": name,
      "wikiPageUrl": wikiPageUrl,
      "confluenceUsername": username,
      "confluenceAccessToken": accessToken,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return KnowledgeUnit.fromJson(jsonData);
    } else {
      String responseBody = await response.stream.bytesToString();
      print('File upload failed: ${response.statusCode}');
      print('Response body: $responseBody');
      throw Exception(response.reasonPhrase);
    }
  }
}
