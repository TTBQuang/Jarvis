import 'package:jarvis/model/pagination_meta.dart';

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

