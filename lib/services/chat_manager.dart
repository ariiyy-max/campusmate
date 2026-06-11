import 'package:flutter/material.dart';
import '../models/chat_user_model.dart';
import '../models/message_model.dart';
import '../homescreen.dart';

class ChatManager extends ChangeNotifier {
  // Singleton pattern - only ONE instance exists
  static final ChatManager _instance = ChatManager._internal();

  factory ChatManager() {
    return _instance;
  }

  ChatManager._internal();

  // Current user
  final String currentUserId = 'current_maya';

  // List of all chat conversations (permanent)
  List<ChatUser> _conversations = [];

  // Messages for each conversation
  Map<String, List<Message>> _messages = {};

  List<ChatUser> get conversations => _conversations;

  // Create a new match/conversation (called when user clicks "Send a Message")
  void createMatch(UserProfile matchedUser) {
    // Check if conversation already exists
    if (_conversations.any((chat) => chat.name == matchedUser.name)) {
      return;
    }

    final newChat = ChatUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: matchedUser.name,
      lastMessage: "",
      lastMessageTime: DateTime.now(),
      major: matchedUser.major,
      avatarPath: matchedUser.assetPath,
      unreadCount: 0,
      isOnline: false,
      imageUrl: null,
    );

    _conversations.insert(0, newChat);
    _messages[newChat.id] = []; // Start with empty messages

    notifyListeners();
  }

  // Send a message
  void sendMessage(String chatId, String text) {
    final newMessage = Message(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    if (_messages[chatId] != null) {
      _messages[chatId]!.add(newMessage);
    } else {
      _messages[chatId] = [newMessage];
    }

    // Update last message in conversation
    final index = _conversations.indexWhere((chat) => chat.id == chatId);
    if (index != -1) {
      _conversations[index] = ChatUser(
        id: _conversations[index].id,
        name: _conversations[index].name,
        lastMessage: text,
        lastMessageTime: DateTime.now(),
        major: _conversations[index].major,
        avatarPath: _conversations[index].avatarPath,
        unreadCount: 0,
        isOnline: _conversations[index].isOnline,
        imageUrl: _conversations[index].imageUrl,
      );
    }

    notifyListeners();
  }

  // Get messages for a chat
  List<Message> getMessages(String chatId) {
    return _messages[chatId] ?? [];
  }

  // Check if already matched
  bool isMatched(String userName) {
    return _conversations.any((chat) => chat.name == userName);
  }

  // Get chat by user name
  ChatUser? getChatByUserName(String userName) {
    try {
      return _conversations.firstWhere((chat) => chat.name == userName);
    } catch (e) {
      return null;
    }
  }

  // Get chat by id
  ChatUser? getChatById(String chatId) {
    try {
      return _conversations.firstWhere((chat) => chat.id == chatId);
    } catch (e) {
      return null;
    }
  }
}