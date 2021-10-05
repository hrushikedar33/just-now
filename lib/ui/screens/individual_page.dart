import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justnow/models/ChatModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justnow/models/message_model.dart';
import 'package:justnow/ui/customui/my_message_card.dart';
import 'package:justnow/ui/customui/reply_card.dart';
import 'package:justnow/ui/pages/camerapage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  IndividualPage({Key key, this.chatModel, this.sourceChat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool showIcon = false;
  FocusNode focusNode = FocusNode();
  IO.Socket _socket;
  bool sendButton = false;
  List<MessageModel> _message = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showIcon = false;
        });
      }
    });
    connect();
  }

  void connect() {
    _socket = IO.io(dotenv.env['user_ip'], <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    _socket.connect();
    _socket.emit("signin", widget.sourceChat.id);
    _socket.onConnect((data) {
      print("Connected");
      _socket.on("message", (msg) {
        print(msg);
        addMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(_socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    addMessage("source", message);
    _socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void addMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      setState(() {
        _message.add(messageModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // todo: adding background image to the chat page
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h), // todo: change height
            child: AppBar(
              leadingWidth: 70.w,
              titleSpacing: 0.0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                      size: 25.h,
                    ),
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/icons/groups.svg"
                            : "assets/icons/person.svg",
                        color: Colors.white,
                        height: 20.h,
                        width: 20.w,
                      ),
                    )
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(5.w), // todo : change padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Online",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.videocam,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Theme.of(context).iconTheme.color,
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
                      child: Text("Group info",
                          style: Theme.of(context).textTheme.bodyText1),
                      value: 'Group info',
                    ),

                    PopupMenuItem(
                        child: Text(
                          "Group Media",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: "Group Media"), //todo
                    PopupMenuItem(
                        child: Text(
                          "Search",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: "Search"), //todo
                    PopupMenuItem(
                        child: Text(
                          "Mute notification",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: "Mute notification"), //todo
                    PopupMenuItem(
                        child: Text(
                          "Wallpaper",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        value: "Wallpaper"),
                  ],
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                // todo: stack
                children: [
                  Expanded(
                    // todo: expanded
                    // height: MediaQuery.of(context).size.height - 140.h,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: _message.length + 1,
                      // padding: EdgeInsets.only(top: 10.h, bottom: 10.h),

                      itemBuilder: (context, index) {
                        if (index == _message.length) {
                          return Container(
                            height: 60.h, // todo : change the height
                          );
                        }
                        if (_message[index].type == "source") {
                          return MyMessageCard(
                            message: _message[index].message,
                            time: _message[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: _message[index].message,
                            time: _message[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      //todo: wrap with container
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 60.w,
                              // width: double.infinity,
                              child: Card(
                                color: Theme.of(context).cardColor,
                                margin: EdgeInsets.only(
                                    left: 2.w, right: 2.w, bottom: 8.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: TextFormField(
                                  controller: _controller,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message",
                                    prefixIcon: IconButton(
                                      icon: Icon(showIcon
                                          ? Icons.keyboard
                                          : Icons.emoji_emotions),
                                      onPressed: () {
                                        if (!showIcon) {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                        }
                                        setState(() {
                                          showIcon = !showIcon;
                                        });
                                      },
                                    ),
                                    // contentPadding: EdgeInsets.all(5.w),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.attach_file),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) =>
                                                  bottomSheet(),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      CameraPage()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    // contentPadding: EdgeInsets.all(5.w),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 8.h, left: 2.w, right: 4.w),
                              child: CircleAvatar(
                                radius: 25.r,
                                child: IconButton(
                                  icon: Icon(
                                    sendButton
                                        ? Icons.send_outlined
                                        : Icons.mic,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  onPressed: () {
                                    if (sendButton) {
                                      // print(_controller.text);
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut);
                                      sendMessage(
                                          _controller.text,
                                          widget.sourceChat.id,
                                          widget.chatModel.id);
                                      _controller.clear();
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        showIcon ? emojiSelect() : Container(),
                      ],
                    ),
                  )
                ],
              ),
              onWillPop: () {
                if (showIcon) {
                  setState(() {
                    showIcon = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278.h,
      width: MediaQuery.of(context).size.width,
      child: Card(
        //todo: colors changing
        color: Theme.of(context).cardColor,
        margin: EdgeInsets.all(18.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(width: 40.w),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(width: 40.w),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallary"),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(width: 40.w),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(width: 40.w),
                  iconCreation(Icons.person, Colors.blue, "Contacts"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            text,
            style:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      bgColor: Theme.of(context).secondaryHeaderColor, //todo
      rows: 4,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        print(emoji);
        setState(() {
          _controller.text = _controller.text + emoji.emoji;
        });
      },
    );
  }
}
