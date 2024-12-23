import 'package:jarvis/config/DioClient.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/model/email.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

class EmailRepository {
  late DioClient dioClient;
  AuthViewModel? authViewModel;

  EmailRepository({this.authViewModel}) {
    dioClient = DioClient(authViewModel: authViewModel);
  }

  Future<SendEmailResponse> sendMessage({
    required String email,
    required String mainIdea,
    AssistantId? assistantId,
    List<ConversationMessage>? conversationMessages,
    String? conversationId,
  }) async {
    try {
      final response = await dioClient.dio.post('/api/v1/ai-email', data: {
        'email': email,
        'mainIdea': mainIdea,
        'assistant': {"id": assistantId?.value, "model": 'dify'},
        'metadata': {
          "context": [],
          "subject": "",
          "sender": "",
          "receiver": "",
          "style": {
            "length": "long",
            "formality": "neutral",
            "tone": "friendly"
          },
          "language": "vietnamese"
        },
        'action': "Reply to this email"
      });
      return SendEmailResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
