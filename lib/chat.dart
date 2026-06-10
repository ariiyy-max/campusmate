import 'package:flutter/material.dart';

// Message model class
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

// Chat User Model
class ChatUser {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String? imageUrl;
  final bool isOnline;
  final int unreadCount;

  ChatUser({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    this.imageUrl,
    this.isOnline = false,
    this.unreadCount = 0,
  });
}

// Chat conversation model
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

// Chat Service to manage conversations
class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  // Store all conversations
  final Map<String, ChatConversation> _conversations = {};

  // Get all conversations list
  List<ChatConversation> getConversations() {
    return _conversations.values.toList()
      ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
  }

  // Check if user has any conversation
  bool hasConversations() {
    return _conversations.isNotEmpty;
  }

  // Get or create conversation
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

  // Add message to conversation
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

  // Get messages for a user
  List<Message> getMessages(String userId) {
    if (_conversations.containsKey(userId)) {
      return _conversations[userId]!.messages;
    }
    return [];
  }
}

// Main Chat Screen (Chat List)
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();

  final List<ChatUser> _availableUsers = [
    ChatUser(
      id: '1',
      name: 'Silvia',
      lastMessage: '',
      lastMessageTime: DateTime.now(),
      isOnline: true,
    ),
    ChatUser(
      id: '2',
      name: 'John Smith',
      lastMessage: '',
      lastMessageTime: DateTime.now(),
      isOnline: false,
    ),
    ChatUser(
      id: '3',
      name: 'Emma Watson',
      lastMessage: '',
      lastMessageTime: DateTime.now(),
      isOnline: true,
    ),
    ChatUser(
      id: '4',
      name: 'Michael Brown',
      lastMessage: '',
      lastMessageTime: DateTime.now(),
      isOnline: false,
    ),
    ChatUser(
      id: '5',
      name: 'Sarah Johnson',
      lastMessage: '',
      lastMessageTime: DateTime.now(),
      isOnline: false,
    ),
    ChatUser(
      id: '6',
      name: 'David Lee',
      lastMessage: '',
      lastMessageTime: DateTime.now(),
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final conversations = _chatService.getConversations();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C31),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1B4E),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Text("Find your member", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: conversations.isEmpty
                    ? _buildNoConversation()
                    : ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final conversation = conversations[index];
                    final lastMessage = conversation.messages.isNotEmpty
                        ? conversation.messages.last
                        : null;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildChatListItem(
                        context: context,
                        userId: conversation.userId,
                        userName: conversation.userName,
                        lastMessage: lastMessage?.text ?? "Tap to start chatting",
                        time: _formatTime(lastMessage?.timestamp ?? conversation.lastUpdated),
                        isOnline: _getUserOnlineStatus(conversation.userId),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoConversation() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF161439),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                size: 60,
                color: Colors.white38,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "No Conversation",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Start a new conversation by selecting a user below",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _availableUsers.map((user) {
                return ActionChip(
                  backgroundColor: const Color(0xFF1D1B4E),
                  label: Text(user.name, style: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    _startNewConversation(user.id, user.name);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatListItem({
    required BuildContext context,
    required String userId,
    required String userName,
    required String lastMessage,
    required String time,
    required bool isOnline,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              userId: userId,
              userName: userName,
              isOnline: isOnline,
            ),
          ),
        ).then((_) => setState(() {}));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF161439),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.purpleAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                if (isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF161439), width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lastMessage,
                    style: const TextStyle(color: Colors.white60, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startNewConversation(String userId, String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
          userId: userId,
          userName: userName,
          isOnline: _getUserOnlineStatus(userId),
          isNewConversation: true,
        ),
      ),
    ).then((_) => setState(() {}));
  }

  bool _getUserOnlineStatus(String userId) {
    final user = _availableUsers.firstWhere((u) => u.id == userId, orElse: () => _availableUsers[0]);
    return user.isOnline;
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else {
      return "${time.day}/${time.month}";
    }
  }
}

// Chat Detail Screen (Individual Chat Conversation)
class ChatDetailScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final bool isOnline;
  final bool isNewConversation;

  const ChatDetailScreen({
    super.key,
    required this.userId,
    required this.userName,
    this.isOnline = false,
    this.isNewConversation = false,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();

  List<Message> _messages = [];
  bool _isTyping = false;

  final Map<String, String> _autoReplies = {
    'hello': 'Hello! How can I help you today?',
    'hi': 'Hi there! Nice to meet you!',
    'how are you': 'I\'m doing great, thanks for asking! How about you?',
    'help': 'Sure! I\'d be happy to help. What do you need assistance with?',
    'thanks': 'You\'re welcome! 😊',
    'thank you': 'You\'re welcome! 😊',
    'bye': 'Goodbye! Have a great day! 👋',
    'goodbye': 'Goodbye! Have a great day! 👋',
  };

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    setState(() {
      _messages = _chatService.getMessages(widget.userId);
    });

    if (_messages.isEmpty) {
      _addWelcomeMessage();
    }

    _scrollToBottom();
  }

  void _addWelcomeMessage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        final welcomeMessage = Message(
          text: "Hello! I am ${widget.userName}. How can I help you today?",
          isUser: false,
        );
        _chatService.addMessage(widget.userId, welcomeMessage);
        setState(() {
          _messages = _chatService.getMessages(widget.userId);
        });
        _scrollToBottom();
      }
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final userMessage = Message(text: text, isUser: true);
    _chatService.addMessage(widget.userId, userMessage);

    setState(() {
      _messages = _chatService.getMessages(widget.userId);
      _messageController.clear();
    });

    _scrollToBottom();

    setState(() {
      _isTyping = true;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
        });

        final reply = _getAutoReply(text);
        final replyMessage = Message(text: reply, isUser: false);
        _chatService.addMessage(widget.userId, replyMessage);

        setState(() {
          _messages = _chatService.getMessages(widget.userId);
        });
        _scrollToBottom();
      }
    });
  }

  String _getAutoReply(String userMessage) {
    String lowerMessage = userMessage.toLowerCase();

    for (var entry in _autoReplies.entries) {
      if (lowerMessage.contains(entry.key)) {
        return entry.value;
      }
    }

    if (lowerMessage.contains('?')) {
      return "That's a great question! Let me think about it and get back to you.";
    }

    return "Thanks for your message! I'll make sure to respond properly. Is there anything specific you'd like to know?";
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return "Yesterday ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    } else {
      return "${time.day}/${time.month} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C31),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C31),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.person, size: 18, color: Colors.white),
                ),
                if (widget.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFF0F0C31), width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userName, style: const TextStyle(color: Colors.white, fontSize: 16)),
                if (widget.isOnline)
                  const Text(
                    "Online",
                    style: TextStyle(color: Colors.green, fontSize: 11),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Call feature coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Video call feature coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty && !_isTyping
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161439),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      size: 40,
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No messages yet",
                    style: TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Start the conversation by sending a message",
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                ],
              ),
            )
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return _buildTypingIndicator();
                }

                final message = _messages[index];
                final isUser = message.isUser;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUser) ...[
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.purple,
                          child: Icon(Icons.person, size: 18, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isUser ? const Color(0xFF8A4FFF) : const Color(0xFF161439),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                message.text,
                                style: const TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(message.timestamp),
                              style: const TextStyle(color: Colors.white38, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      if (isUser) const SizedBox(width: 10),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0C31),
              border: Border.all(color: const Color(0xFF1D1B4E), width: 0.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1B4E),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Type Something...",
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF8A4FFF),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF161439),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "Typing...",
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}