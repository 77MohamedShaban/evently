import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../resources/StringsManager.dart';
import '../../resources/UiUtils.dart';
import 'firestore_manager.dart';
import 'package:evently/model/user.dart' as userModel;

class FireAuthManager {
  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      // Initialize (مرة واحدة فقط)
      await googleSignIn.initialize(
        serverClientId:
            "933132020080-k62kotg108q4tk5c7l4klum0jl5t5r7s.apps.googleusercontent.com",
      );

      // تسجيل الدخول
      final GoogleSignInAccount googleAccount = await googleSignIn
          .authenticate();
      UIUtils.showLoading(context);

      // الحصول على التوكن
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      // Firebase credential (بدون accessToken)
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // تسجيل الدخول في Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;

      // نجاح
      if (context.mounted) {
        FirestoreManager.saveUser(
          userModel.User(
            id: user?.uid,
            name: googleAccount.displayName,
            email: googleAccount.email,
          ),
        );
        UIUtils.hideLoading(context);
        await UIUtils.showToastMessage(
          context,
          StringsManager.loggedInSuccessfully,
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      }
    }on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        debugPrint("User cancelled login");
        return;
      }

    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      if (context.mounted) {
        await UIUtils.showToastMessage(context, StringsManager.somethingWentWrong);
      }
    }
  }

  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    try {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      await googleSignIn.disconnect();
    } catch (e) {
      debugPrint("Sign out error: $e");
    }
  }
}
