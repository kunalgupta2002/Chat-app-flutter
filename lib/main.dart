
import 'package:chatting_app/chat_page.dart';
import 'package:chatting_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const ChatApp());
}

final Logger logger = Logger();

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kunal chat App!",
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginPage(),
      routes: {
        '/chat':(context) => const ChatPage()
      },
    );
  }
}
