import 'package:flutter/material.dart';

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