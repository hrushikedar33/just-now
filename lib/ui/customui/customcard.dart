import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justnow/models/ChatModel.dart';
import 'package:justnow/ui/screens/individual_page.dart';

class CustomCards extends StatelessWidget {
  const CustomCards({Key key, this.chatModel, this.sourceChat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
              sourceChat: sourceChat,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 28.r,
              child: SvgPicture.asset(
                chatModel.isGroup
                    ? "assets/icons/groups.svg"
                    : "assets/icons/person.svg",
                color: Colors.white,
                height: 33.h,
                width: 33.w,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w800, fontSize: 16.sp),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.done_all,
                  color: Colors.lightBlueAccent,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  chatModel.currentMessage,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 13.sp),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80.w, right: 20.w),
            child: Divider(
              thickness: 1.h,
            ),
          )
        ],
      ),
    );
  }
}
