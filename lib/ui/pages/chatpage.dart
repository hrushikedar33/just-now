import 'package:flutter/material.dart';
import 'package:justnow/models/ChatModel.dart';
import 'package:justnow/ui/customui/customcard.dart';
import 'package:justnow/ui/screens/selectcontact.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.chats, this.sourceChat}) : super(key: key);
  final List<ChatModel> chats;
  final ChatModel sourceChat;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectContact(),
            ),
          );
        },
        child: Icon(
          Icons.chat,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (context, index) {
          return CustomCards(
            chatModel: widget.chats[index],
            sourceChat: widget.sourceChat,
          );
        },
      ),
    );
  }
}
