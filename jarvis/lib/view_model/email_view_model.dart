import 'package:flutter/material.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/model/email.dart';
import 'package:jarvis/repository/email_repository.dart';
import 'package:jarvis/view_model/auth_view_model.dart';
import 'package:jarvis/view_model/chat_view_model.dart';

class EmailViewModel extends ChangeNotifier {
  final AuthViewModel authViewModel;
  late EmailRepository emailRepository;
  final ChatViewModel chatViewModel;

  EmailViewModel({
    required this.authViewModel,
    required this.chatViewModel,
  }) {
    emailRepository = EmailRepository(authViewModel: authViewModel);
  }

  List<ConversationMessage>? conversationMessages = [];
  AssistantId? assistantId = AssistantId.gpt_4o_mini;
  bool isLoading = false;
  bool isSending = false;
  String email = ' ';

  Future<void> sendMessage({required String message}) async {
    try {
      isSending = true;
      notifyListeners();
      SendEmailResponse sendEmailResponse = await emailRepository.sendMessage(
        mainIdea: message,
        assistantId: assistantId,
        email: email,
      );

      chatViewModel.setToken(sendEmailResponse.remainingUsage);

      isSending = false;

      conversationMessages?.add(ConversationMessage(
        answer: sendEmailResponse.email,
        query: message,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        files: [],
      ));

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

  void updateEmail(String email) {
    this.email = email;
    notifyListeners();
  }
}
