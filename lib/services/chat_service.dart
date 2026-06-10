import '../models/message_model.dart';

class ChatConversation {
  final String userId;
  final String userName;
  final List<Message> messages;
  final DateTime lastUpdated;

  ChatConversation({
    required this.userId,
    required this.userName,
    required this.messages,
    required this.lastUpdated,
  });
}

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final Map<String, ChatConversation> _conversations = {};

  List<ChatConversation> getConversations() {
    return _conversations.values.toList()
      ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
  }

  bool hasConversations() {
    return _conversations.isNotEmpty;
  }

  ChatConversation getOrCreateConversation(String userId, String userName) {
    if (_conversations.containsKey(userId)) {
      return _conversations[userId]!;
    } else {
      final newConversation = ChatConversation(
        userId: userId,
        userName: userName,
        messages: [],
        lastUpdated: DateTime.now(),
      );
      _conversations[userId] = newConversation;
      return newConversation;
    }
  }

  void addMessage(String userId, Message message) {
    if (_conversations.containsKey(userId)) {
      final conversation = _conversations[userId]!;
      conversation.messages.add(message);
      _conversations[userId] = ChatConversation(
        userId: conversation.userId,
        userName: conversation.userName,
        messages: conversation.messages,
        lastUpdated: DateTime.now(),
      );
    }
  }

  List<Message> getMessages(String userId) {
    if (_conversations.containsKey(userId)) {
      return _conversations[userId]!.messages;
    }
    return [];
  }
}