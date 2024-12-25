import 'package:jarvis/model/knowledge.dart';

class Bot {
  late String name;
  late String createdAt;
  late bool isFavorite;

  Bot({
    required this.name,
    required this.createdAt,
    required this.isFavorite,
  });
}

class BotData {
  late String id;
  late String assistantName;
  late String createdAt;
  late String description;
  late String instructions;

  BotData({
    required this.id,
    required this.assistantName,
    required this.createdAt,
    this.description = '',
    this.instructions = '',
  });

  factory BotData.fromJson(Map<String, dynamic> json) {
    return BotData(
      id: json['id'] ?? '',
      assistantName: json['assistantName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      description: json['description'] ?? '',
      instructions: json['instructions'] ?? '',
    );
  }
}

class GetThreadResponse {
  String id;
  String assistantId;
  String openAiThreadId;

  GetThreadResponse({
    required this.id,
    required this.assistantId,
    required this.openAiThreadId,
  });

  factory GetThreadResponse.fromJson(Map<String, dynamic> json) {
    return GetThreadResponse(
      id: json['id'] ?? '',
      assistantId: json['assistantId'] ?? '',
      openAiThreadId: json['openAiThreadId'] ?? '',
    );
  }

  factory GetThreadResponse.fromGetThreadsJson(Map<String, dynamic> json) {
    if (json['data'].isEmpty) {
      throw Exception('No threads found');
    } else {
      return GetThreadResponse.fromJson(json['data'][json['data'].length - 1]);
    }
  }

  @override
  String toString() =>
      'GetThreadResponse(id: $id, assistantId: $assistantId, openAiThreadId: $openAiThreadId)';
}

class ThreadMessage {
  String role;
  String content;

  ThreadMessage({
    required this.role,
    required this.content,
  });

  factory ThreadMessage.fromJson(Map<String, dynamic> json) {
    return ThreadMessage(
      role: json['role'] ?? '',
      content: json['content'][0]['text']['value'] ?? '',
    );
  }
}

class GetBotsResponse {
  List<BotData> data;

  GetBotsResponse({
    required this.data,
  });

  factory GetBotsResponse.fromJson(Map<String, dynamic> json) {
    return GetBotsResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => BotData.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class GetBotResponse {
  String id;
  String assistantName;
  String createdAt;

  GetBotResponse({
    required this.id,
    required this.assistantName,
    required this.createdAt,
  });

  factory GetBotResponse.fromJson(Map<String, dynamic> json) {
    return GetBotResponse(
      id: json['id'] ?? '',
      assistantName: json['assistantName'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class GetImportedKnowledgeResponse {
  List<Knowledge> data;

  GetImportedKnowledgeResponse({
    required this.data,
  });

  factory GetImportedKnowledgeResponse.fromJson(Map<String, dynamic> json) {
    return GetImportedKnowledgeResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Knowledge.fromJson(item))
              .toList() ??
          [],
    );
  }
}
