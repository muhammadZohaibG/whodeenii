import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/utils/colors.dart';

class CameraComponent extends StatefulWidget {
  final Function(CameraController) onCameraInitialized;
  final Uint8List? bytes;

  const CameraComponent({
    super.key,
    required this.onCameraInitialized,
    required this.bytes,
  });

  @override
  _CameraComponentState createState() => _CameraComponentState();
}

class _CameraComponentState extends State<CameraComponent> {
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _isCameraInitialized
            ? Container(
              width: width * 0.56,
              height: height * 0.56,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CameraPreview(_cameraController!),
            )
            : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera, size: 40, color: Colors.black54),
                  SizedBox(height: 10),
                  Text("Loading Camera..."),
                ],
              ),
            ),
        SizedBox(width: width * 0.01),
        Container(
          width: width * 0.2,
          height: height * 0.25,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              widget.bytes != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(widget.bytes!, fit: BoxFit.cover),
                  )
                  : Center(
                    child: Text(
                      "No Image",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
        ),
      ],
    );
  }
}
