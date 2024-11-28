class Knowledge {
  DateTime? createdAt;
  String? createdBy;
  String description;
  String knowledgeName;
  DateTime? updatedAt;
  String? updatedBy;
  String userId;
  String id;
  double numUnits;
  double totalSize;

  Knowledge({
    required this.createdAt,
    required this.createdBy,
    required this.description,
    required this.knowledgeName,
    required this.updatedAt,
    required this.updatedBy,
    required this.userId,
    required this.id,
    required this.numUnits,
    required this.totalSize,
  });

  factory Knowledge.fromJson(Map<String, dynamic> json) {
    return Knowledge(
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: json['createdBy'],
      description: json['description'] ?? '',
      knowledgeName: json['knowledgeName'] ?? '',
      updatedAt: DateTime.parse(json['updatedAt']),
      updatedBy: json['updatedBy'],
      userId: json['userId'] ?? '',
      id: json['id'] ?? '',
      numUnits: (json['numUnits'] ?? 0) * 1.0,
      totalSize: (json['totalSize'] ?? 0) * 1.0,
    );
  }
}