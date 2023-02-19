import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google Sign in
  signInWithGoogle() async {
    // begin interative sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtains auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //final lets sign in
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return user;
  }

  //Create users in firebase
  addUserToFireStore(String uid, String? email, String? userName) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      "username": userName,
      "email": email,
      "order": [],
      "history": [],
      "favorite": [],
      "search": [],
    });
    return true;
  }
}
