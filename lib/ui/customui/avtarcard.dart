import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justnow/models/ChatModel.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key key, this.contact}) : super(key: key);
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //todo
        children: [
          Stack(
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
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 11.r,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            contact.name,
            style:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
