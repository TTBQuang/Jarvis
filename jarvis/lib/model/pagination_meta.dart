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