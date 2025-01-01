import 'package:jarvis/config/KBClient.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view_model/auth_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BotRepository {
  late KBClient kbClient;
  AuthViewModel? authViewModel;

  BotRepository({this.authViewModel}) {
    kbClient = KBClient(authViewModel: authViewModel);
  }

  Future<void> publishSlackBot(
      {required String assistantId, required Map<String, String> data}) async {
    try {
      final response = await kbClient.dio.post(
          '/kb-core/v1/bot-integration/slack/publish/$assistantId',
          data: data);

      final Uri url = Uri.parse(response.data['redirect']);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> publishTelegramBot(
      {required String assistantId, required Map<String, String> data}) async {
    final response = await kbClient.dio.post(
      '/kb-core/v1/bot-integration/telegram/publish/$assistantId',
      data: data,
    );

    final Uri url = Uri.parse(response.data['redirect']);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> publishMessengerBot(
      {required String assistantId, required Map<String, String> data}) async {
    final response = await kbClient.dio.post(
      '/kb-core/v1/bot-integration/messenger/publish/$assistantId',
      data: data,
    );

    final Uri url = Uri.parse(response.data['redirect']);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> createNewThread({required String assistantId}) async {
    try {
      await kbClient.dio
          .post('/kb-core/v1/ai-assistant/thread/playground', data: {
        'assistantId': assistantId,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetThreadResponse> createThread(
      {required String assistantId, String? message}) async {
    try {
      final response =
          await kbClient.dio.post('/kb-core/v1/ai-assistant/thread', data: {
        'firstMessage': message,
        'assistantId': assistantId,
      });

      return GetThreadResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> sendThreadMessage(
      {required String message,
      required String assistantId,
      required String openAiThreadId}) async {
    try {
      final response = await kbClient.dio
          .post('/kb-core/v1/ai-assistant/$assistantId/ask', data: {
        'message': message,
        'openAiThreadId': openAiThreadId,
        'instructions': '',
      });

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ThreadMessage>> getThreadMessages({
    required String openAiThreadId,
  }) async {
    try {
      final response = await kbClient.dio
          .get('/kb-core/v1/ai-assistant/thread/$openAiThreadId/messages');

      // Check if response.data is a List
      if (response.data is List) {
        // Ensure each item in the list is a Map<String, dynamic>
        return (response.data as List)
            .map((json) =>
                ThreadMessage.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } else {
        throw Exception(
            'Expected response.data to be a List, but got: ${response.data.runtimeType}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetThreadResponse?> getThread({required String assistantId}) async {
    try {
      final response = await kbClient.dio
          .get('/kb-core/v1/ai-assistant/$assistantId/threads');

      return GetThreadResponse.fromGetThreadsJson(response.data);
    } catch (e) {
      return null;
    }
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
