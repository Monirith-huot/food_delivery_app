import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../auth.widget.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  const SignupScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  var passwordVisible = true;
  var repasswordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: LoadingAnimationWidget.beat(
            color: COLORS.primary,
            size: 40,
          ),
        );
      },
    );
    try {
      if (passwordController.text == repasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        const PopupWidget(
            errorMessage: "Passwords dont match",
            recommedMessage: "Recheck your both passwords again");
      }
      Navigator.pop(context);
    } on FirebaseAuthException {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: _pageSize - (100 + _notifySize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(
                    title: " Become one of us 🤘",
                    caption: "Eat your favourite food, at any time",
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  const CustomText(
                    text: "Email Address",
                    size: SIZE.textSize,
                    color: COLORS.black,
                    weight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller: emailController,
                    enabled: true,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: COLORS.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: COLORS.primary),
                      ),
                      focusColor: COLORS.primary,
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 23, maxHeight: 20),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.email_outlined,
                          color: COLORS.grey,
                        ),
                      ),
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                        color: COLORS.grey,
                        fontSize: 14,
                        fontFamily: "Product-Sans",
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  const CustomText(
                    text: "Password",
                    size: SIZE.textSize,
                    color: COLORS.black,
                    weight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //NOTES: For passwords
                  TextFormField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    enabled: true,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: COLORS.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: COLORS.primary),
                      ),
                      focusColor: COLORS.primary,
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 23, maxHeight: 20),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.lock_open,
                          color: COLORS.grey,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Icon(
                              passwordVisible
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off,
                              color: COLORS.grey),
                        ),
                      ),
                      hintText: "Enter your password",
                      hintStyle: const TextStyle(
                        color: COLORS.grey,
                        fontSize: 14,
                        fontFamily: "Product-Sans",
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  const CustomText(
                    text: "Comfirm password",
                    size: SIZE.textSize,
                    color: COLORS.black,
                    weight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //NOTES: For passwords
                  TextFormField(
                    controller: repasswordController,
                    obscureText: repasswordVisible,
                    enabled: true,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: COLORS.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: COLORS.primary),
                      ),
                      focusColor: COLORS.primary,
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 23, maxHeight: 20),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.lock_open,
                          color: COLORS.grey,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              repasswordVisible = !repasswordVisible;
                            });
                          },
                          child: Icon(
                              repasswordVisible
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off,
                              color: COLORS.grey),
                        ),
                      ),
                      hintText: "Re-Enter your password",
                      hintStyle: const TextStyle(
                        color: COLORS.grey,
                        fontSize: 14,
                        fontFamily: "Product-Sans",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        signUp();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: COLORS.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: SIZE.medimunButtonWidth,
                        height: SIZE.buttonHeight,
                        alignment: Alignment.center,
                        child: const CustomText(
                          text: "Sign up",
                          size: SIZE.textSize,
                          color: COLORS.white,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Row(
                    children: const [
                      Expanded(child: Divider(color: COLORS.grey)),
                      SizedBox(width: 21),
                      CustomText(
                          text: "Or Signup With",
                          size: SIZE.subTextSize,
                          color: COLORS.black,
                          weight: FontWeight.normal),
                      SizedBox(width: 21),
                      Expanded(child: Divider(color: COLORS.grey)),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Row(
                    children: [
                      CustomizeButtonNavigation(
                        bgColor: COLORS.white,
                        border: true,
                        width: 170,
                        to: GetStartScreen(),
                        child: Image.asset("assets/images/google_icon.png"),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      CustomizeButtonNavigation(
                        bgColor: COLORS.white,
                        border: true,
                        width: 170,
                        to: GetStartScreen(),
                        child: Image.asset("assets/images/facebook_icon.png"),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  // BottomWidget(
                  //     to: LoginScreen(),
                  //     captionText: "Already have an account ? ",
                  //     navigationCaption: "Login Now")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Already have an account ? ",
                        size: SIZE.subTextSize,
                        weight: FontWeight.normal,
                        color: COLORS.black,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const CustomText(
                          text: "Login Now ",
                          size: SIZE.subTextSize,
                          weight: FontWeight.bold,
                          color: COLORS.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
