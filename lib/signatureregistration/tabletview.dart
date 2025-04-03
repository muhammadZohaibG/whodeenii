import 'package:signature/signature.dart';
import 'package:whodeenii/components/custombuttoncomponent.dart';
import 'package:whodeenii/components/dialogbox.dart';
import 'package:whodeenii/service/api.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/sizeconf.dart';
import 'package:flutter/material.dart';
import 'package:whodeenii/utils/values.dart';

class Signview extends StatefulWidget {
  final VoidCallback prevPressed;
  final VoidCallback nextPressed;
  const Signview({
    super.key,
    required this.prevPressed,
    required this.nextPressed,
  });

  @override
  _SignviewState createState() => _SignviewState();
}

class _SignviewState extends State<Signview> {
  String paragraph = '';
  bool isLoading = true;
  Future<void> fetchtermsData() async {
    final termscondiionsparagraph = await Api.getTermsAndConditions();
    if (termscondiionsparagraph != null) {
      isLoading = false;
      paragraph = termscondiionsparagraph;
      if (mounted) {
        setState(() {});
      }
      print(termscondiionsparagraph);
    } else {
      setState(() {
        isLoading = true;
      });
    }
  }

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    initsign();
    fetchtermsData();
  }

  void initsign() async {
    if (_signatureController.isNotEmpty) {
      var signature = await _signatureController.toPngBytes();
      if (signature != null) {
        print("Signature captured!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.02,
        right: width * 0.02,
        top: height * 0.025,
      ),
      child: SizedBox(
        width: width,
        height: height * 0.74,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.62,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.009),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Registration Card",
                              style: TextStyle(
                                fontSize: width * 0.012,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black.withOpacity(0.3),
                                  builder: (BuildContext context) {
                                    return BlurredDialog(
                                      title: "Registration Card",
                                      content:
                                          isLoading
                                              ? signaturevalue
                                              : paragraph,
                                    );
                                  },
                                );
                              },
                              child: Image.asset(max),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: height * 0.4,
                                ),
                                child: Text(
                                  signaturevalue,
                                  style: TextStyle(fontSize: width * 0.012),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height * 0.62,
                  width: width * 0.37,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.009,
                      right: width * 0.009,
                      bottom: width * 0.009,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Signature",
                              style: TextStyle(
                                fontSize: width * 0.012,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _signatureController.clear();
                                });
                              },
                              icon: Image.asset(bin),
                            ),
                          ],
                        ),
                        Container(
                          height: height * 0.54,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Signature(
                              controller: _signatureController,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  buttonText: 'Previous',
                  onPressed: widget.prevPressed,
                  btnbg: AppColors.gray4959,
                  btnfg: AppColors.whiteColor,
                  height: height * 0.052,
                  width: width * 0.43,
                ),
                SizedBox(width: width * 0.02),
                CustomButton(
                  buttonText: 'Next',
                  onPressed: widget.nextPressed,
                  btnbg: AppColors.primaryColor,
                  btnfg: AppColors.whiteColor,
                  height: height * 0.052,
                  width: width * 0.43,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
