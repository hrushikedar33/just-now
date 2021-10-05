import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String time;
  const MyMessageCard({Key key, this.message, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45.w,
        ),
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          color: Theme.of(context).cardTheme.color,
          shadowColor: Theme.of(context).cardTheme.shadowColor,
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 25.w,
                  top: 5.h,
                  bottom: 20.h,
                ),
                child: Text(
                  message,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 13.h),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 10.h),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 15.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
