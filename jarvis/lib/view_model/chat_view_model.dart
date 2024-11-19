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
  AssistantId? assistantId = AssistantId.gpt_4o_mini;

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
      getConversation(
          conversationId: conversationId!, assistantId: assistantId);
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
      getConversation(
          conversationId: conversationId!, assistantId: assistantId);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> getConversation(
      {required String conversationId, AssistantId? assistantId}) async {
    try {
      GetConversationResponse conversationResponse =
          await chatRepository.getConversation(
              conversationId: conversationId, assistantId: assistantId);

      conversationMessages = conversationResponse.items;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> sendMessage(
      {required String message, AssistantId? assistantId}) async {
    try {
      await chatRepository.sendMessage(
          conversationMessages: conversationMessages,
          conversationId: conversationId,
          content: message,
          assistantId: assistantId);

      getConversation(
          conversationId: conversationId!, assistantId: assistantId);
      notifyListeners();
    } catch (e) {}
  }
}
