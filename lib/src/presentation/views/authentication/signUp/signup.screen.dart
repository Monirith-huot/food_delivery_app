import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth.widget.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

import '../auth_service/auth_service.dart';
import 'package:food_delivery_app/src/controllers/controller.dart';

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
  final userNameController = TextEditingController();

  var passwordVisible = true;
  var repasswordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  Future signUp() async {
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
      //create users for auth
      if (passwordController.text == repasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        addUserDetails(
          userNameController.text.trim(),
          emailController.text.trim(),
        );
      } else {
        erorrMessage(
            "Passwords dont match", "Recheck your both passwords again");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == "email-already-in-use") {
        erorrMessage("Look like you already have an account",
            "You already register with this account. Please login with that gmail");
      } else if (e.code == 'weak-password') {
        erorrMessage("Look like your password is a bit weak",
            "Please choose strong password / Long passwords");
      } else if (e.code == "invalid-email") {
        erorrMessage("Look like your gmail is not a right format",
            "Please recheck your gmail format and retry again !");
      }
    }
  }

  Future addUserDetails(String userName, String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('uuid', uid);
    context.read<UUIDController>().adduuid(uid);
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      "username": userNameController.text,
      "email": emailController.text,
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("favorite")
        .doc("1")
        .set({});
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("order")
        .doc("1")
        .set({});
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("history")
        .doc("1")
        .set({});
  }

  Future<UserCredential> signInWithGoogle() async {
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
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setString('uuid', user.user!.uid);
      // context.read<UUIDController>().adduuid(user.user!.uid);
      Navigator.pop(context);
      return user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }
  }

  void erorrMessage(String errorMessage, String recommendMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupWidget(
          errorMessage: errorMessage,
          recommedMessage: recommendMessage,
        );
      },
    );
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
                    height: 30,
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
                    height: 30,
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
                            color: COLORS.grey,
                          ),
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

                  const CustomText(
                    text: "Username",
                    size: SIZE.textSize,
                    color: COLORS.black,
                    weight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //NOTES: For passwords
                  TextFormField(
                    controller: userNameController,
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
                          Icons.person_4_outlined,
                          color: COLORS.grey,
                        ),
                      ),
                      hintText: "Enter your username",
                      hintStyle: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signInWithGoogle().then((value) => AuthService()
                              .addUserToFireStore(value.user!.uid,
                                  value.user!.email, value.user!.displayName));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: COLORS.white,
                            border: Border.all(
                                color: COLORS.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          width: SIZE.medimunButtonWidth,
                          height: SIZE.buttonHeight,
                          child: Image.asset("assets/images/google_icon.png"),
                        ),
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
