import 'dart:convert';
import 'package:jarvis/config/DioClient.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

class ChatRepository {
  late DioClient dioClient;
  AuthViewModel? authViewModel;

  ChatRepository({this.authViewModel}) {
    dioClient = DioClient(authViewModel: authViewModel);
  }

  Future<GetConversationsResponse> getConversations({
    String? cursor,
    int? limit,
    AssistantId? assistantId,
  }) async {
    try {
      final response = await dioClient.dio
          .get('/api/v1/ai-chat/conversations', queryParameters: {
        if (limit != null) 'limit': limit.toString(),
        if (cursor != null) 'cursor': cursor,
        if (assistantId != null) 'assistantId': assistantId.value,
        'assistantModel': 'dify',
      });
      return GetConversationsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CreateConversationResponse> createConversation({
    required String content,
    AssistantId? assistantId,
    List<String>? files,
  }) async {
    try {
      final response = await dioClient.dio.post('/api/v1/ai-chat', data: {
        'content': content,
        'assistant': {"id": assistantId?.value, "model": 'dify'},
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
    AssistantId? assistantId,
  }) async {
    try {
      final response = await dioClient.dio.get(
          '/api/v1/ai-chat/conversations/$conversationId/messages',
          queryParameters: {
            if (limit != null) 'limit': limit.toString(),
            if (cursor != null) 'cursor': cursor,
            if (assistantId != null) 'assistantId': assistantId.value,
            'assistantModel': 'dify',
          });
      return GetConversationResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendMessage({
    required String content,
    AssistantId? assistantId,
    List<ConversationMessage>? conversationMessages,
    String? conversationId,
  }) async {
    try {
      await dioClient.dio.post('/api/v1/ai-chat/messages', data: {
        'content': content,
        'assistant': {"id": assistantId?.value, "model": 'dify'},
        'metadata': {
          "conversation": {"id": conversationId, "messages": []}
        },
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
