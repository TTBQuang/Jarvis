import 'package:flutter/material.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:jarvis/repository/bot_repository.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

class BotViewModel extends ChangeNotifier {
  final AuthViewModel authViewModel;
  late BotRepository botRepository;

  BotViewModel({
    required this.authViewModel,
  }) {
    botRepository = BotRepository(authViewModel: authViewModel);
  }

  List<BotData> bots = [];
  BotData? selectedBot;
  bool isCreating = false;
  bool isLoading = false;
  List<Knowledge> importedKnowledge = [];
  GetThreadResponse? thread;
  List<ThreadMessage> conversationMessages = [];
  bool isSending = false;

  Future<void> publishSlackBot(
      {required String assistantId, required Map<String, String> data}) async {
    try {
      await botRepository.publishSlackBot(assistantId: assistantId, data: {
        'botToken': data['Token']!,
        'clientId': data['Client ID']!,
        'clientSecret': data['Client Secret']!,
        'signingSecret': data['Signing Secret']!
      });
    } catch (e) {}
  }

  Future<void> publishTelegramBot(
      {required String assistantId, required Map<String, String> data}) async {
    try {
      await botRepository.publishTelegramBot(
          assistantId: assistantId, data: {'botToken': data['Token']!});
    } catch (e) {}
  }

  Future<void> publishMessengerBot(
      {required String assistantId, required Map<String, String> data}) async {
    try {
      await botRepository.publishMessengerBot(assistantId: assistantId, data: {
        'botToken': data['Messenger Bot Token']!,
        'pageId': data['Messenger Bot Page ID']!,
        'appSecret': data['Messenger Bot App Secret']!
      });
    } catch (e) {}
  }

  Future<void> createNewThread() async {
    try {
      conversationMessages = [];
      GetThreadResponse threadResponse =
          await botRepository.createThread(assistantId: selectedBot!.id);
      thread = threadResponse;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> sendThreadMessage({required String message}) async {
    try {
      isSending = true;
      notifyListeners();
      String messageResponse = await botRepository.sendThreadMessage(
          message: message,
          assistantId: selectedBot!.id,
          openAiThreadId: thread!.openAiThreadId);

      conversationMessages.add(ThreadMessage(
        role: 'user',
        content: message,
      ));
      conversationMessages
          .add(ThreadMessage(role: 'assistant', content: messageResponse));
    } catch (e) {
      print(e);
    } finally {
      isSending = false;
      notifyListeners();
    }
  }

  Future<void> getThread({required String assistantId}) async {
    try {
      GetThreadResponse? threadResponse =
          await botRepository.getThread(assistantId: assistantId);
      thread = threadResponse;
      if (threadResponse != null) {
        conversationMessages = await botRepository.getThreadMessages(
            openAiThreadId: threadResponse.openAiThreadId);
      } else {
        GetThreadResponse threadResponse =
            await botRepository.createThread(assistantId: selectedBot!.id);
        thread = threadResponse;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createBot({required String name, String? description}) async {
    try {
      isCreating = true;
      notifyListeners();
      await botRepository.createBot(
        name: name,
        description: description,
      );

      getBots();
      notifyListeners();
    } catch (e) {
    } finally {
      isCreating = false;
      notifyListeners();
    }
  }

  Future<void> getBots({
    String? q,
    bool? isPublished,
    bool? isFavorite,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      GetBotsResponse botsResponse = await botRepository.getBots(
          q: q, isPublished: isPublished, isFavorite: isFavorite);

      bots = botsResponse.data;
      notifyListeners();
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBot({required String assistantId}) async {
    try {
      GetBotResponse botResponse =
          await botRepository.getBot(assistantId: assistantId);

      selectedBot = new BotData(
          id: botResponse.id,
          assistantName: botResponse.assistantName,
          createdAt: botResponse.createdAt);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> selecteBot({required BotData bot}) async {
    try {
      selectedBot = bot;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> updateBot(
      {required String assistantId,
      required String name,
      String? description,
      String? instructions}) async {
    try {
      isCreating = true;
      notifyListeners();
      await botRepository.updateBot(
          assistantId: assistantId,
          name: name,
          description: description,
          instructions: instructions);
      getBots();
      notifyListeners();
    } catch (e) {
    } finally {
      isCreating = false;
      notifyListeners();
    }
  }

  Future<void> deleteBot({required String assistantId}) async {
    try {
      isLoading = true;
      notifyListeners();
      await botRepository.deleteBot(assistantId: assistantId);
      getBots();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> getImportedKnowledge({required String assistantId}) async {
    try {
      final GetImportedKnowledgeResponse importedKnowledgeResponse =
          await botRepository.getImportedKnowledge(assistantId: assistantId);

      importedKnowledge = importedKnowledgeResponse.data;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> addKnowledge(
      {required String knowledgeId, required String assistantId}) async {
    try {
      await botRepository.addKnowledge(
          knowledgeId: knowledgeId, assistantId: assistantId);
      getImportedKnowledge(assistantId: assistantId);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> removeKnowledge(
      {required String knowledgeId, required String assistantId}) async {
    try {
      await botRepository.removeKnowledge(
          knowledgeId: knowledgeId, assistantId: assistantId);
      getImportedKnowledge(assistantId: assistantId);
      notifyListeners();
    } catch (e) {}
  }
}
