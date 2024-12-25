import 'package:jarvis/config/KBClient.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

class BotRepository {
  late KBClient kbClient;
  AuthViewModel? authViewModel;

  BotRepository({this.authViewModel}) {
    kbClient = KBClient(authViewModel: authViewModel);
  }

  Future<void> createBot({
    required String name,
    String? description,
  }) async {
    try {
      await kbClient.dio.post('/kb-core/v1/ai-assistant', data: {
        'assistantName': name,
        'description': description,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetBotsResponse> getBots({
    String? q,
    bool? isPublished,
    bool? isFavorite,
  }) async {
    try {
      final response =
          await kbClient.dio.get('/kb-core/v1/ai-assistant', queryParameters: {
        if (q != null) 'q': q,
        if (isPublished != null) 'is_published': isPublished.toString(),
        if (isFavorite != null) 'is_favorite': isFavorite.toString(),
      });
      return GetBotsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetBotResponse> getBot({
    required String assistantId,
  }) async {
    try {
      final response =
          await kbClient.dio.get('/kb-core/v1/ai-assistant/$assistantId');
      return GetBotResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateBot({
    required String assistantId,
    required String name,
    String? description,
    String? instructions,
  }) async {
    try {
      await kbClient.dio.patch('/kb-core/v1/ai-assistant/$assistantId', data: {
        'assistantName': name,
        'description': description,
        'instructions': instructions,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteBot({
    required String assistantId,
  }) async {
    try {
      await kbClient.dio.delete('/kb-core/v1/ai-assistant/$assistantId');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetImportedKnowledgeResponse> getImportedKnowledge({
    required String assistantId,
  }) async {
    try {
      final response = await kbClient.dio
          .get('/kb-core/v1/ai-assistant/$assistantId/knowledges');

      return GetImportedKnowledgeResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addKnowledge({
    required String knowledgeId,
    required String assistantId,
  }) async {
    try {
      await kbClient.dio.post(
          '/kb-core/v1/ai-assistant/$assistantId/knowledges/$knowledgeId');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeKnowledge({
    required String knowledgeId,
    required String assistantId,
  }) async {
    try {
      await kbClient.dio.delete(
          '/kb-core/v1/ai-assistant/$assistantId/knowledges/$knowledgeId');
    } catch (e) {
      throw Exception(e);
    }
  }
}
