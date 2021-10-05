import 'package:flutter/material.dart';
import 'package:justnow/justnow.dart';
import 'package:justnow/models/ChatModel.dart';
import 'package:justnow/ui/pages/camerapage.dart';
import 'package:justnow/ui/pages/chatpage.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.chats, this.sourceChat}) : super(key: key);
  final List<ChatModel> chats;
  final ChatModel sourceChat;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "JustNow!",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {},
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_rounded),
              // color: Theme.of(context).iconTheme.color,
              onSelected: (value) {
                print(value);
                // Note You must create respective pages for navigation
                // Navigator.pushNamed(context, value);
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: Text("New Group",
                      style: Theme.of(context).textTheme.bodyText1),
                  value: 'New Group',
                ),

                PopupMenuItem(
                    child: Text(
                      "New Brodcast",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    value: "New Brodcast"), //todo
                PopupMenuItem(
                    child: Text(
                      "WhatsApp Web",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    value: "WhatsApp Web"), //todo
                PopupMenuItem(
                    child: Text(
                      "Starred Messages",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    value: "Starred Messages"), //todo
                PopupMenuItem(
                    child: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    value: ""),
              ],
            ), //todo
            ChangeThemeButtonWidget(),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).iconTheme.color,
            labelColor: Theme.of(context).iconTheme.color,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "Status",
              ),
              Tab(
                text: "Calls",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            CameraPage(),
            ChatPage(
              chats: widget.chats,
              sourceChat: widget.sourceChat,
            ),
            Text("status"),
            Text("calls"),
          ],
        ));
  }
}
