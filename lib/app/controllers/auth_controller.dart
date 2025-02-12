import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get steramAuthStatus => auth.authStateChanges();

  void resetPassword(String email) async {
    if (email.isNotEmpty && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.dialog(
          AlertDialog(
            title: Text('Reset Password'),
            content: Text(
                'We have sent you an email, please reset your password: $email'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred. Please try again.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
          print('No user found for that email.');
        }
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        print(e);
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      final UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.dialog(
          AlertDialog(
            title: Text('Email not verified'),
            content: Text('Do you want to resend the verification email?'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('No'),
                style: TextButton.styleFrom(
                    foregroundColor: Get.theme.colorScheme.secondary),
              ),
              TextButton(
                onPressed: () {
                  credential.user!.sendEmailVerification();
                  Get.back();
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
        print('Wrong password provided for that user.');
      }
      print('errorMessage: ${e.code}');
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void singup(String email, String password) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      Get.dialog(
        AlertDialog(
          title: Text('Email verification'),
          content: Text(
              'We have sent you an email, please verify your email: $email'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
        print('The account already exists for that email.');
      }
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
