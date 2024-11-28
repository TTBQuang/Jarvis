import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:jarvis/model/knowledge_list.dart';

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

  Future<void> deleteKnowledge(
      {required User user, required String id}) async {
    var headers = {
      'x-jarvis-guid':
          user.userToken?.tokenKb.accessToken == null ? user.userUuid : '',
      'Authorization': user.userToken?.tokenKb.accessToken == null
          ? ''
          : 'Bearer ${user.userToken?.tokenKb.accessToken}',
    };
    var request = http.Request('DELETE', Uri.parse('$baseUrlKb/kb-core/v1/knowledge/$id'));

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
