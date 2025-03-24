import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CaptureDoc extends StatefulWidget {
  final VoidCallback prevPressed;
  final VoidCallback existingPressed;
  final VoidCallback capPressed;
  final Function(CameraController) onCameraInitialized;
  const CaptureDoc({
    super.key,
    required this.prevPressed,
    required this.capPressed,
    required this.existingPressed,
    required this.onCameraInitialized,
  });

  @override
  _CaptureDocState createState() => _CaptureDocState();
}

class _CaptureDocState extends State<CaptureDoc> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![0], ResolutionPreset.medium);

    await _cameraController!.initialize();
    if (!mounted) return;

    setState(() {
      _isCameraInitialized = true;
    });
    widget.onCameraInitialized(_cameraController!);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    MySize().init(context);
    return Column(
      children: [
        SizedBox(
          width: width,
          height: height * 0.68,
          child: Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Place your ID doc in the middle of rectangle",
                  style: TextStyle(
                    fontSize: width * 0.0138,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height * 0.07),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.02),
                      child: Container(
                        width: width * 0.42,
                        height: height * 0.45,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            _isCameraInitialized
                                ? CameraPreview(_cameraController!)
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera,
                                      size: 40,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Capture ID Doc",
                                      style: TextStyle(
                                        fontSize: width * 0.012,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: height * 0.013,
            left: width * 0.02,
            right: width * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                buttonText: 'Previous',
                onPressed: widget.prevPressed,
                btnbg: AppColors.gray4959,
                btnfg: AppColors.whiteColor,
                height: height * 0.054,
                width: width * 0.26,
              ),
              SizedBox(width: width * 0.02),
              CustomButton(
                buttonText: 'Keep Existing',
                onPressed: widget.existingPressed,
                btnbg: AppColors.primaryColor,
                btnfg: AppColors.whiteColor,
                height: height * 0.054,
                width: width * 0.26,
              ),
              SizedBox(width: width * 0.02),
              CustomButton(
                buttonText: 'Capture',
                onPressed: widget.capPressed,
                btnbg: AppColors.blackColor,
                btnfg: AppColors.whiteColor,
                height: height * 0.054,
                width: width * 0.26,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
