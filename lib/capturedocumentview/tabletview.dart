import 'dart:convert';
import 'dart:typed_data';

import 'package:whodeenii/capturedocumentview/camerawithimage.dart';
import 'package:whodeenii/capturedocumentview/onlycamera.dart';
import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/service/api.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:whodeenii/views/capturedocuments.dart';

class CaptureDoc extends StatefulWidget {
  final bool captureimageonce;
  final VoidCallback prevPressed;
  final VoidCallback existingPressed;
  final VoidCallback capPressed;
  final Function(CameraController) onCameraInitialized;
  const CaptureDoc({
    super.key,
    required this.captureimageonce,
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
  bool isimageFound = false;
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    getimage();
    _initializeCamera();
  }

  Future<void> getimage() async {
    final profile = await Api.fetchdocumentfromapi();
    if (profile != null) {
      final String base64String = profile['fileContent'];
      bytes = base64Decode(base64String.split(',').last);
      if (mounted) {
        setState(() {
          isimageFound = true;
        });
      }
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        debugPrint("No cameras found");
        return;
      }
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      await _cameraController!.initialize();
      if (!mounted) return;
      setState(() {});
      widget.onCameraInitialized(_cameraController!);
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
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
                isimageFound
                    ? CameraComponent(
                      onCameraInitialized: widget.onCameraInitialized,
                      bytes: bytes,
                    )
                    : OnlyCameraComponent(
                      onCameraInitialized: widget.onCameraInitialized,
                    ),
              ],
            ),
          ),
        ),
        isimageFound
            ? Padding(
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
                    buttonText: 'Capture',
                    onPressed: widget.capPressed,
                    btnbg: AppColors.blackColor,
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
                ],
              ),
            )
            : widget.captureimageonce
            ? Padding(
              padding: EdgeInsets.only(
                top: height * 0.013,
                left: width * 0.02,
                right: width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonText: 'Discard',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaptureDocuments(),
                        ),
                      );
                    },
                    btnbg: AppColors.gray4959,
                    btnfg: AppColors.whiteColor,
                    height: height * 0.054,
                    width: width * 0.26,
                  ),
                  SizedBox(width: width * 0.02),
                  CustomButton(
                    buttonText: 'ReCapture',
                    onPressed: widget.capPressed,
                    btnbg: AppColors.blackColor,
                    btnfg: AppColors.whiteColor,
                    height: height * 0.054,
                    width: width * 0.26,
                  ),

                  SizedBox(width: width * 0.02),
                  CustomButton(
                    buttonText: 'Continue',
                    onPressed: widget.existingPressed,
                    btnbg: AppColors.primaryColor,
                    btnfg: AppColors.whiteColor,
                    height: height * 0.054,
                    width: width * 0.26,
                  ),
                ],
              ),
            )
            : Padding(
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
                    width: width * 0.42,
                  ),
                  SizedBox(width: width * 0.02),
                  CustomButton(
                    buttonText: 'Capture',
                    onPressed: widget.capPressed,
                    btnbg: AppColors.primaryColor,
                    btnfg: AppColors.whiteColor,
                    height: height * 0.054,
                    width: width * 0.42,
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
