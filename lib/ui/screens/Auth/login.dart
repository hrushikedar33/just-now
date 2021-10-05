import 'package:flutter/material.dart';
import 'package:justnow/models/ChatModel.dart';
import 'package:justnow/ui/customui/buttoncard.dart';
import 'package:justnow/ui/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel(
      name: "Hrushikesh",
      currentMessage: "Welcome to app",
      isGroup: false,
      time: "06:56",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Narendra",
      currentMessage: "Welcome to app",
      isGroup: false,
      time: "04:56",
      icon: "person.svg",
      id: 2,
    ),
    // ChatModel(
    //   name: "New Group",
    //   currentMessage: "Welcome to app",
    //   isGroup: true,
    //   time: "04:56",
    //   icon: "group.svg",
    // ),
    // ChatModel(
    //   name: "friends",
    //   currentMessage: "Welcome to app",
    //   isGroup: true,
    //   time: "10:56",
    //   icon: "group.svg",
    // ),
    ChatModel(
      name: "Anyone",
      currentMessage: "Welcome to this flutter",
      isGroup: false,
      time: "04:00",
      icon: "person.svg",
      id: 3,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              sourceChat = chats.removeAt(index);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => HomeScreen(
                          chats: chats,
                          sourceChat: sourceChat,
                        )),
              );
            },
            child: ButtonCard(
              name: chats[index].name,
              icon: Icons.person,
            ),
          );
        },
      ),
    );
  }
}
