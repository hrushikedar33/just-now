import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justnow/models/ChatModel.dart';
import 'package:justnow/ui/customui/avtarcard.dart';

import 'package:justnow/ui/customui/contactcard.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
      name: "Hsh",
      status: "Get Busy Living Get busy Dying",
    ),
    ChatModel(
      name: "Hrushih",
      status: "Get Busy Living Get busy Dying",
    ),
    ChatModel(
      name: "ushikesh",
      status: "Get Busy Living Get busy Dying",
    ),
    ChatModel(
      name: "ikesh",
      status: "Get Busy Living Get busy Dying",
    ),
    ChatModel(
      name: "hikesh",
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
  List<ChatModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w800),
            ),
            Text(
              "Add Participants",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 20.h,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  height: groups.length > 0 ? 90.h : 10.h,
                );
              }

              return InkWell(
                onTap: () {
                  if (contacts[index - 1].select == false) {
                    setState(() {
                      contacts[index - 1].select = true;
                      groups.add(contacts[index - 1]);
                    });
                  } else {
                    setState(() {
                      contacts[index - 1].select = false;
                      groups.remove(contacts[index - 1]);
                    });
                  }
                },
                child: ContactCard(
                  contact: contacts[index - 1],
                ),
              );
            },
          ),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: 75.h,
                      child: ListView.builder(
                        itemCount: contacts.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          if (contacts[index].select == true) {
                            return InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    groups.remove(contacts[index]);
                                    contacts[index].select = false;
                                  },
                                );
                              },
                              child: AvatarCard(
                                contact: contacts[index],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
