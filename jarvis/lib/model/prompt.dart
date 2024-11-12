import 'package:jarvis/model/language.dart';

import 'category.dart';

class Prompt {
  String id;
  Category category;
  String content;
  String createdAt;
  String description;
  bool isFavorite;
  bool isPublic;
  Language language;
  String title;
  String updatedAt;
  String userId;
  String userName;

  Prompt({
    required this.id,
    required this.category,
    required this.content,
    required this.createdAt,
    required this.description,
    required this.isFavorite,
    required this.isPublic,
    required this.language,
    required this.title,
    required this.updatedAt,
    required this.userId,
    required this.userName,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['_id'] ?? '',
      category: Category.fromApiValue(json['category'] ?? ''),
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? '',
      description: json['description'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      isPublic: json['isPublic'] ?? false,
      language: Language.fromString(json['language'] ?? ''),
      title: json['title'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
    );
  }

  Prompt copyWith({
    String? id,
    Category? category,
    String? content,
    String? createdAt,
    String? description,
    bool? isFavorite,
    bool? isPublic,
    Language? language,
    String? title,
    String? updatedAt,
    String? userId,
    String? userName,
  }) {
    return Prompt(
      id: id ?? this.id,
      category: category ?? this.category,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isPublic: isPublic ?? this.isPublic,
      language: language ?? this.language,
      title: title ?? this.title,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  @override
  String toString() {
    return '''
Prompt(
  id: $id,
  category: ${category.displayName},
  content: $content,
  createdAt: $createdAt,
  description: $description,
  isFavorite: $isFavorite,
  isPublic: $isPublic,
  language: $language,
  title: $title,
  updatedAt: $updatedAt,
  userId: $userId,
  userName: $userName
)
''';
  }
}
