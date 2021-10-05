import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justnow/ui/screens/cameraView.dart';
import 'package:justnow/ui/screens/video_view.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  bool _isRecording = false;
  bool _flash = false;
  bool _isFront = true;
  double transform = 0;
  // String videoPath = "";

  Future<void> cameraValue;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CameraPreview(_cameraController));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          _flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28.h,
                        ),
                        onPressed: () {
                          setState(() {
                            _flash = !_flash;
                          });
                          _flash
                              ? _cameraController.setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        },
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          // final path = join(
                          //     (await getTemporaryDirectory()).path,
                          //     "${DateTime.now()}.mp4");
                          await _cameraController.startVideoRecording();
                          setState(() {
                            _isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile videoPath =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            _isRecording = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => VideoViewPage(
                                path: videoPath.path,
                              ),
                            ),
                          );
                        },
                        onTap: () {
                          if (!_isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: _isRecording
                            ? Icon(
                                Icons.radio_button_on,
                                size: 70.h,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                size: 70.h,
                                color: Colors.white,
                              ),
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                          child: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28.h,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isFront = !_isFront;
                            transform = transform + pi;
                          });
                          int cameraPos = _isFront ? 0 : 1;
                          _cameraController = CameraController(
                              cameras[cameraPos], ResolutionPreset.high);
                          cameraValue = _cameraController.initialize();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Hold for Video, tap for photo",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 12.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    // final path =
    //     join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile file = await _cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraViewPage(
            path: file.path,
          ),
        ));
  }
}
