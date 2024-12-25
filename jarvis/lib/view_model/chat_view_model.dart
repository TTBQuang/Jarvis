import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/model/subscription.dart';
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
  int token = 10;
  bool isLoading = false;
  bool isSending = false;
  File? image;

  void setImage(File? image) {
    this.image = image;
    notifyListeners();
  }

  void setToken(int token) {
    this.token = token;
    notifyListeners();
  }

  Future<void> getConversations({
    String? cursor,
    int? limit,
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

  Future<void> sendMessage({required String message}) async {
    try {
      isSending = true;
      notifyListeners();
      if (conversationId == null) {
        CreateConversationResponse createConversationResponse =
            await chatRepository.createConversation(
                content: message,
                assistantId: assistantId,
                files: image != null ? await getBase64Strings([image!]) : null);

        token = createConversationResponse.remainingUsage;
        conversationId = createConversationResponse.conversationId;
        conversations?.insert(
            0,
            Conversation(
                createdAt: DateTime.now().microsecondsSinceEpoch,
                title: message,
                id: conversationId!));
        getConversation(
            conversationId: conversationId!, assistantId: assistantId);
      } else {
        SendMessageResponse sendMessageResponse =
            await chatRepository.sendMessage(
                conversationMessages: conversationMessages,
                conversationId: conversationId,
                content: message,
                assistantId: assistantId,
                files: image != null ? await getBase64Strings([image!]) : null);

        token = sendMessageResponse.remainingUsage;
        getConversation(
            conversationId: conversationId!, assistantId: assistantId);
      }

      isSending = false;
      notifyListeners();
    } catch (e) {
    } finally {
      isSending = false;
      notifyListeners();
    }
  }

  void changeAssistant(AssistantId assistantId) {
    this.assistantId = assistantId;
    notifyListeners();
  }

  void changeConversation(String? conversationId) async {
    isLoading = true;
    notifyListeners();
    this.conversationId = conversationId;
    if (conversationId != null) {
      await getConversation(
          conversationId: conversationId, assistantId: assistantId);
    } else {
      conversationMessages = [];
    }
    isLoading = false;
    notifyListeners();
  }

  void getUsage() async {
    try {
      Subscription subscription =
          await chatRepository.getUsage(authViewModel.user);
      if (subscription.name == SubscriptionType.basic) {
        token = subscription.dailyTokens;
      } else {
        token = -1;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

Future<List<String>> getBase64Strings(List<File> files) async {
  List<String> base64Strings = [];
  for (var file in files) {
    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64Encode(fileBytes);
    base64Strings.add(base64String);
  }
  return base64Strings;
}
