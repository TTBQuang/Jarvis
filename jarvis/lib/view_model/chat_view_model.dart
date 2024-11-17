import 'package:flutter/material.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/repository/chat_repository.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

class ChatViewModel extends ChangeNotifier {
  final AuthViewModel authViewModel;
  late ChatRepository chatRepository;

  ChatViewModel({
    required this.authViewModel,
  }) {
    chatRepository = ChatRepository(authViewModel: authViewModel);
  }

  List<Conversation>? conversations = [];
  String? conversationId;
  List<ConversationMessage>? conversationMessages = [];

  Future<void> getConversations({
    String? cursor,
    int? limit,
    AssistantId? assistantId,
  }) async {
    try {
      GetConversationsResponse conversationsResponse =
          await chatRepository.getConversations(
        cursor: cursor,
        limit: limit,
        assistantId: assistantId,
      );

      conversations = conversationsResponse.items;
      conversationId = conversations?.first.id;
      getConversation(conversationId!);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> createConversation(
      {required String content,
      AssistantId? assistantId,
      List<String>? files}) async {
    try {
      CreateConversationResponse createConversationResponse =
          await chatRepository.createConversation(
        content: content,
        assistantId: assistantId,
        files: files,
      );

      conversationId = createConversationResponse.conversationId;
      getConversation(conversationId!);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> getConversation(String conversationId) async {
    try {
      GetConversationResponse conversationResponse =
          await chatRepository.getConversation(conversationId: conversationId);

      conversationMessages = conversationResponse.items;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> sendMessage(String message) async {
    try {
      await chatRepository.sendMessage(
        conversationMessages: conversationMessages,
        conversationId: conversationId,
        content: message,
      );

      getConversation(conversationId!);
      notifyListeners();
    } catch (e) {}
  }
}
