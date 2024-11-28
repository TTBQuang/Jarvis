import 'knowledge.dart';

class KnowledgeList {
  List<Knowledge> data;
  PaginationMeta meta;

  KnowledgeList({
    required this.data,
    required this.meta,
  });

  factory KnowledgeList.fromJson(Map<String, dynamic> json) {
    return KnowledgeList(
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Knowledge.fromJson(item))
              .toList() ??
          [],
      meta: PaginationMeta.fromJson(json['meta'] ?? {}),
    );
  }
}

class PaginationMeta {
  bool hasNext;
  double limit;
  double offset;
  double total;

  PaginationMeta({
    required this.hasNext,
    required this.limit,
    required this.offset,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      hasNext: json['hasNext'] ?? false,
      limit: (json['limit'] ?? 0) * 1.0,
      offset: (json['offset'] ?? 0) * 1.0,
      total: (json['total'] ?? 0) * 1.0,
    );
  }
}
