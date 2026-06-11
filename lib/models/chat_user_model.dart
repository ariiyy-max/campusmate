import 'package:flutter/material.dart';
import 'package:campusmate/homescreen.dart';

class ChatUser {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String? imageUrl;
  final bool isOnline;
  final int unreadCount;
  final String major;
  final String avatarPath;

  ChatUser({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    this.imageUrl,
    this.isOnline = false,
    this.unreadCount = 0,
    required this.major,
    required this.avatarPath,
  });

  factory ChatUser.fromUserProfile(UserProfile profile) {
    return ChatUser(
      id: profile.name.toLowerCase(),
      name: profile.name,
      lastMessage: '',
      lastMessageTime: DateTime.now(),
      major: profile.major,
      avatarPath: profile.assetPath,
    );
  }
}
