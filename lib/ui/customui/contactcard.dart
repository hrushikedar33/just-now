import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justnow/models/ChatModel.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key key, this.contact}) : super(key: key);
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50.h,
        width: 50.w,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23.r,
              child: SvgPicture.asset(
                "assets/icons/person.svg",
                color: Colors.white,
                height: 30.h,
                width: 30.w,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            contact.select
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 11.r,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18.h,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        contact.name,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        contact.status,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13.sp),
      ),
    );
  }
}
