import 'dart:io';
import 'package:whodeenii/service/api.dart';
import 'package:camera/camera.dart';
import 'package:whodeenii/capturedocumentview/mobileview.dart';
import 'package:whodeenii/capturedocumentview/tabletview.dart';
import 'package:whodeenii/components/headercomponenet.dart';
import 'package:whodeenii/components/mobHeaderComponent.dart';
import 'package:whodeenii/service/navigationservice.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/values.dart';
import 'package:whodeenii/views/profiledetail.dart';
import 'package:whodeenii/views/singatureregistration.dart';
import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class CaptureDocuments extends StatefulWidget {
  const CaptureDocuments({super.key});

  @override
  State<CaptureDocuments> createState() => _CaptureDocumentsState();
}

class _CaptureDocumentsState extends State<CaptureDocuments> {
  CameraController? _cameraController;
  bool captureonce = false;
  void testsub() {}
  void prevbutton() {
    NavigationService.pushReplacement(ProfileDetail());
  }

  void nextbutton() {
    NavigationService.pushReplacement(SignatureRegistration());
  }

  void _onCameraControllerInitialized(CameraController controller) {
    setState(() {
      _cameraController = controller;
    });
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final XFile image = await _cameraController!.takePicture();
        debugPrint("Captured Image Path: ${image.path}");
        File imageFile = File(image.path);
        bool success = await Api.uploadDocumentImage(imageFile);
        if (success) {
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Success",
              text: "Image uploaded successfully!",
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CaptureDocuments()),
          );
          setState(() {});
        } else {
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Error",
              text: "Image upload failed",
            ),
          );
        }
        captureonce = true;
        setState(() {});
      } catch (e) {
        debugPrint("Error capturing image: $e");
      }
    } else {
      debugPrint("Camera is not initialized!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isTablet = width > 600;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(bgimage, fit: BoxFit.cover)),
          Padding(
            padding: EdgeInsets.all(width * 0.03),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(homewhite),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Column(
                  children: [
                    isTablet
                        ? HeaderComponent(
                          lineLogo: line2,
                          poweredByLogo: logo,
                          heading: "Upload or Capture ID Document",
                          contentline: uploaddetails,
                        )
                        : MobHeaderComponent(
                          lineLogo: line2,
                          farimontlogo: farimontlogo,
                          heading: "Upload or Capture ID Document",
                          contentline: uploaddetails,
                        ),
                    isTablet
                        ? CaptureDoc(
                          prevPressed: prevbutton,
                          existingPressed: nextbutton,
                          capPressed: _captureImage,
                          onCameraInitialized: _onCameraControllerInitialized,
                          captureimageonce: captureonce,
                        )
                        : CaptureDocM(
                          prevPressed: prevbutton,
                          existingPressed: nextbutton,
                          capPressed: nextbutton,
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
