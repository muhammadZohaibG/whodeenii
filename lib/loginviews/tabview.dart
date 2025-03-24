import 'package:flutter/material.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';
import 'package:whodeenii/utils/sizeconf.dart';

class LoginFormT extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool isLoading;
  final Function(bool?) onRememberMeChanged;
  final VoidCallback onLoginPressed;

  const LoginFormT({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onLoginPressed,
    required this.isLoading,
  });

  @override
  State<LoginFormT> createState() => _LoginFormTState();
}

class _LoginFormTState extends State<LoginFormT> {
  final loginKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MySize().init(context);
    return Form(
      key: loginKey,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.04),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(whodeenii, height: height * 0.06),
            SizedBox(height: height * 0.13),
            Text(
              "Login",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: width * 0.015,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              "Please enter your credentials to login",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: MySize.size16,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: height * 0.04),
            SizedBox(
              width: width * 0.3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Email", style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: width * 0.3,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  ).hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                controller: widget.emailController,
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter email",
                  hintStyle: TextStyle(color: AppColors.gray300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(email),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),
            SizedBox(
              width: width * 0.3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Enter Password", style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: width * 0.3,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else {
                    return null;
                  }
                },
                controller: widget.passwordController,
                obscureText: isPasswordVisible,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Enter password",
                  hintStyle: TextStyle(color: AppColors.gray300),
                  prefixIcon: Image.asset(lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: width * 0.3,
              child: Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      checkboxTheme: CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(color: AppColors.gray4959),
                      ),
                    ),
                    child: Checkbox(
                      value: widget.rememberMe,
                      onChanged: widget.onRememberMeChanged,
                      activeColor: Colors.orange,
                    ),
                  ),
                  Text(
                    "Remember Me",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: width * 0.3,
              height: 45,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.gradientdarkColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    widget.isLoading
                        ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                        : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.whiteColor,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (loginKey.currentState!.validate()) {
                              widget.onLoginPressed();
                            }
                          },
                          child: const Text("Confirm"),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
