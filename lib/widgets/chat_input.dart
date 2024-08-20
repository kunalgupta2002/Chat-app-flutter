import 'package:chatting_app/models/chat_message_entity.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class ChatInput extends StatelessWidget {
  final Function(ChatMessageEntity) onSubmit;
  ChatInput({super.key, required this.onSubmit});

  final chatMessageController = TextEditingController();

  void onSendButtonPressed() {
    logger.i('ChatMessage: ${chatMessageController.text}');

    final newChatMessage = ChatMessageEntity(
        text: chatMessageController.text,
        id: "244",
        createdAt: DateTime.now().microsecondsSinceEpoch,
        author: Author(userName: 'kunal!'));

    onSubmit(newChatMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const Padding(
                      padding: EdgeInsets.all(100.0),
                      child: Text('hello!'),
                    );
                  });
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              controller: chatMessageController,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Type your Message",
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: onSendButtonPressed,
            icon: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
