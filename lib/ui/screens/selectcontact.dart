import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justnow/models/ChatModel.dart';
import 'package:justnow/ui/customui/buttoncard.dart';
import 'package:justnow/ui/customui/contactcard.dart';
import 'package:justnow/ui/screens/creategroup.dart';

class SelectContact extends StatefulWidget {
  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
      ChatModel(
        name: "Hrushikesh",
        status: "Get Busy Living Get busy Dying",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w800),
            ),
            Text(
              "256 Contacts",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 20.h,
              ),
              onPressed: () {}),
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
                child: Text("Invite a friend",
                    style: Theme.of(context).textTheme.bodyText1),
                value: 'Invite a friend',
              ),

              PopupMenuItem(
                  child: Text(
                    "Contacts",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: "Contacts"), //todo
              PopupMenuItem(
                  child: Text(
                    "Refresh",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: "Refresh"), //todo
              PopupMenuItem(
                  child: Text(
                    "Help",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: "Help"), //todo
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateGroup()));
                },
                child: ButtonCard(icon: Icons.group, name: "new group"));
          } else if (index == 1) {
            return ButtonCard(icon: Icons.person_add, name: "new contact");
          }
          return ContactCard(
            contact: contacts[index - 2],
          );
        },
      ),
    );
  }
}
