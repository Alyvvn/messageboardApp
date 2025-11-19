import 'package:flutter/material.dart';

class MessageBoard {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  MessageBoard({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });

  // Hardcoded list of message boards
  static List<MessageBoard> getBoards() {
    return [
      MessageBoard(
        id: 'general',
        name: 'General Discussion',
        description: 'Talk about anything and everything',
        icon: Icons.forum,
        color: Colors.blue,
      ),
      MessageBoard(
        id: 'tech',
        name: 'Tech Talk',
        description: 'Discuss the latest in technology',
        icon: Icons.computer,
        color: Colors.purple,
      ),
      MessageBoard(
        id: 'sports',
        name: 'Sports',
        description: 'All things sports related',
        icon: Icons.sports_basketball,
        color: Colors.orange,
      ),
      MessageBoard(
        id: 'entertainment',
        name: 'Entertainment',
        description: 'Movies, music, TV shows and more',
        icon: Icons.movie,
        color: Colors.red,
      ),
      MessageBoard(
        id: 'food',
        name: 'Food & Cooking',
        description: 'Share recipes and food experiences',
        icon: Icons.restaurant,
        color: Colors.green,
      ),
      MessageBoard(
        id: 'travel',
        name: 'Travel',
        description: 'Share your travel stories and tips',
        icon: Icons.flight,
        color: Colors.teal,
      ),
    ];
  }
}

