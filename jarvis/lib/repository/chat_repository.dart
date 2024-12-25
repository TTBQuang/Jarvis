import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:jarvis/config/DioClient.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/model/subscription.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

import '../model/user.dart';

class ChatRepository {
  late DioClient dioClient;
  AuthViewModel? authViewModel;

  ChatRepository({this.authViewModel}) {
    dioClient = DioClient(authViewModel: authViewModel);
  }

  Future<GetConversationsResponse> getConversations({
    String? cursor,
    int? limit,
    String? assistantId,
  }) async {
    try {
      final response = await dioClient.dio
          .get('/api/v1/ai-chat/conversations', queryParameters: {
        if (limit != null) 'limit': limit.toString(),
        if (cursor != null) 'cursor': cursor,
        if (assistantId != null) 'assistantId': assistantId,
        'assistantModel': 'dify',
      });
      return GetConversationsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CreateConversationResponse> createConversation({
    required String content,
    String? assistantId,
    List<String>? files,
  }) async {
    try {
      final response = await dioClient.dio.post('/api/v1/ai-chat', data: {
        'content': content,
        'assistant': {"id": assistantId, "model": 'dify'},
        if (files != null) 'files': files,
      });
      return CreateConversationResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetConversationResponse> getConversation({
    required String conversationId,
    String? cursor,
    int? limit,
    String? assistantId,
  }) async {
    try {
      final response = await dioClient.dio.get(
          '/api/v1/ai-chat/conversations/$conversationId/messages',
          queryParameters: {
            if (limit != null) 'limit': limit.toString(),
            if (cursor != null) 'cursor': cursor,
            if (assistantId != null) 'assistantId': assistantId,
            'assistantModel': 'dify',
          });
      return GetConversationResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SendMessageResponse> sendMessage({
    required String content,
    String? assistantId,
    List<ConversationMessage>? conversationMessages,
    String? conversationId,
    List<String>? files,
  }) async {
    try {
      final response =
          await dioClient.dio.post('/api/v1/ai-chat/messages', data: {
        'content': content,
        'assistant': {"id": assistantId, "model": 'dify'},
        'metadata': {
          "conversation": {"id": conversationId, "messages": []}
        },
        if (files != null) 'files': files
      });
      return SendMessageResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Subscription> getUsage(User user) async {
    try {
      var headers = {
        'x-jarvis-guid': user.userToken?.tokenJarvis.accessToken == null
            ? user.userUuid
            : '',
        'Authorization': user.userToken?.tokenJarvis.accessToken == null
            ? ''
            : 'Bearer ${user.userToken?.tokenJarvis.accessToken}',
      };
      print(headers);
      var request = http.Request(
          'GET', Uri.parse('$baseUrlJarvis/api/v1/subscriptions/me'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> json = jsonDecode(responseBody);
        return Subscription.fromJson(json);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
