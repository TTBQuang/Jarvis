import 'package:jarvis/model/prompt.dart';

class PromptList {
  bool hasNext;
  List<Prompt> items;
  int limit;
  int offset;
  int total;

  PromptList({
    required this.hasNext,
    required this.items,
    required this.limit,
    required this.offset,
    required this.total,
  });

  factory PromptList.fromJson(Map<String, dynamic> json) {
    return PromptList(
      hasNext: json['hasNext'] ?? false,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => Prompt.fromJson(item))
              .toList() ??
          [],
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  PromptList copyWith({
    List<Prompt>? items,
    int? total,
    int? limit,
    int? offset,
    bool? hasNext,
  }) {
    return PromptList(
      items: items ?? this.items,
      total: total ?? this.total,
      hasNext: hasNext ?? this.hasNext,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  String toString() {
    return '''
PromptList(
  hasNext: $hasNext,
  items: ${items.length} items,
  limit: $limit,
  offset: $offset,
  total: $total
)
''';
  }
}
