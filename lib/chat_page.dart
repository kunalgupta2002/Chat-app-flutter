import 'dart:convert';
import 'package:chatting_app/models/chat_message_entity.dart';
import 'package:chatting_app/models/image_model.dart';
import 'package:chatting_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:chatting_app/widgets/chat_bubble.dart';
import 'package:http/http.dart' as http;

final Logger logger = Logger();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _messages = [];

  Future<void> _loadInitialMessages() async {
    final String response = await rootBundle.loadString("assets/mock_messages.json");
    final List<dynamic> decodedList = jsonDecode(response) as List;
    final List<ChatMessageEntity> chatMessages = decodedList.map((listItem) {
      return ChatMessageEntity.fromJson(listItem);
    }).toList();
    logger.i('Loaded initial messages');

    setState(() {
      _messages = chatMessages;
    });
  }

  void onMessageSent(ChatMessageEntity entity) {
    setState(() {
      _messages.add(entity);
    });
  }

  Future<List<PixelfordImage>> _getNetworkImages() async {
    var endpointUrl = Uri.parse('https://simple-books-api.glitch.me/books');
    final response = await http.get(endpointUrl);

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;
      final List<PixelfordImage> imageList = decodedList.map((listItem) {
        return PixelfordImage.fromJson(listItem);
      }).toList();
      logger.i('Fetched network images');

      return imageList;
    } else {
      throw Exception('API not successful!');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi $username!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
              logger.i('icon pressed');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<PixelfordImage>>(
            future: _getNetworkImages(),
            builder: (BuildContext context, AsyncSnapshot<List<PixelfordImage>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No images available');
              } else {
                return Image.network(snapshot.data![0].urlFullSize);
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  alignment: _messages[index].author.userName == "kunal!"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  entity: _messages[index],
                );
              },
            ),
          ),
          ChatInput(
            onSubmit: onMessageSent,
          ),
        ],
      ),
    );
  }
}
