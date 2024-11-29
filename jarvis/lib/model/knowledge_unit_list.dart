import 'package:jarvis/model/pagination_meta.dart';

import 'knowledge_unit.dart';

class KnowledgeUnitList {
  List<KnowledgeUnit> data;
  PaginationMeta meta;

  KnowledgeUnitList({
    required this.data,
    required this.meta,
  });

  factory KnowledgeUnitList.fromJson(Map<String, dynamic> json) {
    return KnowledgeUnitList(
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => KnowledgeUnit.fromJson(item))
              .toList() ??
          [],
      meta: PaginationMeta.fromJson(json['meta'] ?? {}),
    );
  }
}