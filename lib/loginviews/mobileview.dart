import 'package:flutter/material.dart';
import 'package:whodeenii/utils/colors.dart';
import 'package:whodeenii/utils/images.dart';

class LoginFormM extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final Function(bool?) onRememberMeChanged;
  final VoidCallback onLoginPressed;

  const LoginFormM({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onLoginPressed,
  });

  @override
  State<LoginFormM> createState() => _LoginFormMState();
}

class _LoginFormMState extends State<LoginFormM> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(whodeenii, height: height * 0.04),
          SizedBox(height: height * 0.1),
          Text(
            "Login",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
              fontFamily: 'DM Sans',
            ),
          ),
          Text(
            "Please enter your credentials to login",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: width * 0.035,
              fontFamily: 'DM Sans',
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: width * 0.65,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Email", style: TextStyle(fontSize: 16)),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: width * 0.65,
            child: TextField(
              controller: widget.usernameController,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter email",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Image.asset(email),
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
            width: width * 0.65,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Password", style: TextStyle(fontSize: 16)),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: width * 0.65,
            child: TextField(
              controller: widget.passwordController,
              obscureText: isPasswordVisible,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter password",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Image.asset(lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
            width: width * 0.65,
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
            width: width * 0.65,
            height: 45,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradientColor.colors.first,
                    AppColors.gradientColor.colors.last,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: widget.onLoginPressed,
                child: const Text("Confirm"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
