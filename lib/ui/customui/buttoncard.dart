import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key key, this.name, this.icon}) : super(key: key);
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23.r,
        child: Icon(
          icon,
          color: Colors.white,
          size: 26.h,
        ),
        backgroundColor: Colors.green[700],
      ),
      title: Text(
        name,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
