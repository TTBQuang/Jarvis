class KnowledgeUnit {
  DateTime? createdAt;
  String? createdBy;
  String id;
  String knowledgeId;
  String name;
  String type;
  bool status;
  DateTime? updatedAt;
  String? updatedBy;
  String userId;
  double size;

  KnowledgeUnit({
    required this.createdAt,
    required this.createdBy,
    required this.id,
    required this.knowledgeId,
    required this.name,
    required this.type,
    required this.status,
    required this.updatedAt,
    required this.updatedBy,
    required this.userId,
    required this.size,
  });

  factory KnowledgeUnit.fromJson(Map<String, dynamic> json) {
    return KnowledgeUnit(
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: json['createdBy'],
      id: json['id'] ?? '',
      knowledgeId: json['knowledgeId'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? false,
      updatedAt: DateTime.parse(json['updatedAt']),
      updatedBy: json['updatedBy'],
      userId: json['userId'] ?? '',
      size: (json['size'] ?? 0) * 1.0,
    );
  }
}

// {
// "data": [
// {
// "createdAt": "2024-11-29T10:21:38.506Z",
// "updatedAt": "2024-11-29T10:21:38.506Z",
// "createdBy": null,
// "updatedBy": null,
// "deletedAt": null,
// "id": "9e3b07d3-cc6a-401d-9f60-64704c0c5f2a",
// "name": "aa.html",
// "type": "local_file",
// "size": 1435,
// "status": true,
// "userId": "4a8b8184-133b-4325-a16b-f1f1168ae054",
// "knowledgeId": "26f44c7e-f5a1-4773-b6db-54840c29de18",
// "openAiFileIds": [
// "file-59NhZDxWLhUgtAQohnfZ4j"
// ],
// "metadata": {
// "name": "aa.html",
// "mimetype": "text/html"
// }
// }
// ],
// "meta": {
// "limit": 20,
// "offset": 0,
// "total": 1,
// "hasNext": false
// }
// }


// local:
// {
// "name": "link video demo.txt",
// "type": "local_file",
// "knowledgeId": "26f44c7e-f5a1-4773-b6db-54840c29de18",
// "userId": "4a8b8184-133b-4325-a16b-f1f1168ae054",
// "openAiFileIds": [
// "file-4gvZ9fwh4bTUsPKPEorFPx"
// ],
// "size": 110,
// "metadata": {
// "mimetype": "text/plain",
// "name": "link video demo.txt"
// },
// "createdBy": null,
// "updatedBy": null,
// "createdAt": "2024-11-29T14:05:28.442Z",
// "updatedAt": "2024-11-29T14:05:28.442Z",
// "deletedAt": null,
// "id": "02f02170-37d2-4e3b-8e5c-c11bd7722450",
// "status": true
// }