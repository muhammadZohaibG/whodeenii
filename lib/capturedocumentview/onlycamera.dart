import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/utils/colors.dart';

class OnlyCameraComponent extends StatefulWidget {
  final Function(CameraController) onCameraInitialized;

  const OnlyCameraComponent({super.key, required this.onCameraInitialized});

  @override
  _OnlyCameraComponentState createState() => _OnlyCameraComponentState();
}

class _OnlyCameraComponentState extends State<OnlyCameraComponent> {
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
    return _isCameraInitialized
        ? Container(
          width: width * 0.9,
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
        );
  }
}
