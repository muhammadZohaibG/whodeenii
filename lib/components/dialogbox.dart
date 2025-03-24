import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';

class BlurredDialog extends StatelessWidget {
  final String title;
  final String content;

  const BlurredDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(bgimage, fit: BoxFit.cover)),
        Padding(
          padding: EdgeInsets.only(
            top: height * 0.017,
            left: width * 0.03,
            right: width * 0.03,
            bottom: height * 0.005,
          ),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: EdgeInsets.only(
                  top: height * 0.035,
                  left: width * 0.142,
                  right: width * 0.135,
                  bottom: height * 0.035,
                ),
                child: Container(
                  width: width * 0.5,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.silver95.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.013,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: height * 0.66,
                        child: SingleChildScrollView(
                          child: Text(
                            content,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: width * 0.014),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.033),
                      CustomButton(
                        buttonText: "Close",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        btnbg: AppColors.primaryColor,
                        btnfg: AppColors.whiteColor,
                        height: height * 0.06,
                        width: width,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
