class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? messageId;
  final bool isRead;

  Message({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
    this.messageId,
    this.isRead = false,
  }) : timestamp = timestamp ?? DateTime.now();
}