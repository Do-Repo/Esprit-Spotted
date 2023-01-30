import 'dart:convert';

class Message {
  String message;
  DateTime createdAt;
  Message({
    required this.message,
    required this.createdAt,
  });

  Message copyWith({
    String? message,
    DateTime? createdAt,
  }) {
    return Message(
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(message: $message, createdAt: $createdAt)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.message == message && other.createdAt == createdAt;
  }

  @override
  int get hashCode => message.hashCode ^ createdAt.hashCode;
}
