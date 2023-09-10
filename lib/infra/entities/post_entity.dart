// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/*
EXEMPLO:
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
}
*/

class PostEntity {
  final String title;
  final String body;
  final int id;
  final int userId;
  PostEntity({
    required this.title,
    required this.body,
    required this.id,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'id': id,
      'userId': userId,
    };
  }

  factory PostEntity.fromMap(Map<String, dynamic> map) {
    return PostEntity(
      title: map['title'] as String,
      body: map['body'] as String,
      id: map['id'] as int,
      userId: map['userId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostEntity.fromJson(String source) =>
      PostEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostEntity(title: $title, body: $body, id: $id, userId: $userId)';
  }

  PostEntity copyWith({
    String? title,
    String? body,
    int? id,
    int? userId,
  }) {
    return PostEntity(
      title: title ?? this.title,
      body: body ?? this.body,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }
}
