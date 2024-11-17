class Conversation {
  int createdAt;
  String title;
  String id;

  Conversation({
    required this.createdAt,
    required this.title,
    required this.id,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      createdAt: json['created_at'] ?? 0,
      title: json['title'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

class GetConversationsResponse {
  String cursor;
  bool has_more;
  int limit;
  List<Conversation> items;

  GetConversationsResponse({
    required this.cursor,
    required this.has_more,
    required this.limit,
    required this.items,
  });

  factory GetConversationsResponse.fromJson(Map<String, dynamic> json) {
    return GetConversationsResponse(
      cursor: json['cursor'] ?? '',
      has_more: json['has_more'] ?? false,
      limit: json['limit'] ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => Conversation.fromJson(item))
              .toList() ??
          [],
    );
  }

  GetConversationsResponse copyWith({
    String? cursor,
    bool? has_more,
    int? limit,
    List<Conversation>? items,
  }) {
    return GetConversationsResponse(
      cursor: cursor ?? this.cursor,
      has_more: has_more ?? this.has_more,
      limit: limit ?? this.limit,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return '''
PromptList(
  cursor: $cursor,
  has_more: $has_more,
  limit: $limit,
  items: ${items.length} items
)
''';
  }
}

class CreateConversationResponse {
  String conversationId;
  String message;
  int remainingUsage;

  CreateConversationResponse({
    required this.conversationId,
    required this.message,
    required this.remainingUsage,
  });

  factory CreateConversationResponse.fromJson(Map<String, dynamic> json) {
    return CreateConversationResponse(
      conversationId: json['conversationId'] ?? '',
      message: json['message'] ?? '',
      remainingUsage: json['remainingUsage'] ?? 0,
    );
  }
}

class ConversationMessage {
  String answer;
  int createdAt;
  List<String> files;
  String query;

  ConversationMessage({
    required this.answer,
    required this.createdAt,
    required this.files,
    required this.query,
  });

  factory ConversationMessage.fromJson(Map<String, dynamic> json) {
    return ConversationMessage(
      answer: json['answer'] ?? '',
      createdAt: json['created_at'] ?? 0,
      files: (json['files'] as List<dynamic>?)?.cast<String>() ?? [],
      query: json['query'] ?? '',
    );
  }
}

class GetConversationResponse {
  String cursor;
  bool has_more;
  int limit;
  List<ConversationMessage> items;

  GetConversationResponse({
    required this.cursor,
    required this.has_more,
    required this.limit,
    required this.items,
  });

  factory GetConversationResponse.fromJson(Map<String, dynamic> json) {
    return GetConversationResponse(
      cursor: json['cursor'] ?? '',
      has_more: json['has_more'] ?? false,
      limit: json['limit'] ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => ConversationMessage.fromJson(item))
              .toList() ??
          [],
    );
  }
}

enum AssistantId {
  gpt_4o_mini('gpt-4o-mini', 'GPT-4o mini'),
  gpt_4o('gpt-4o', 'GPT-4o'),
  gemini_pro('gemini-1.5-pro-latest', 'Gemini 1.5 Pro'),
  gemini_flash('gemini-1.5-flash-latest', 'Gemini 1.5 Flash'),
  claude_haiku('claude-3-haiku-20240307', 'Claude 3 Haiku'),
  claude_sonnet('claude-3-5-sonnet-20240620', 'Claude 3.5 Sonnet');

  final String value;
  final String name;

  const AssistantId(this.value, this.name);

  static AssistantId fromValue(String value) {
    return AssistantId.values.firstWhere(
      (assistantId) => assistantId.value == value,
      orElse: () => AssistantId.gpt_4o_mini,
    );
  }
}
