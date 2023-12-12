import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/introduction_page.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/signin_page.dart';
import 'package:unipark_uitm_app/src/features/core/pages/navigation_menu.dart';
import 'package:unipark_uitm_app/src/data/repositories/exceptions/firebase_auth_exception.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() {
    final user = _auth.currentUser;

    // if the user is logged in
    if (user != null) {
      Get.offAll(() => const NavigationMenu()); // redirect to HomePage
    } else {
      Get.offAll(() => const IntroductionPage()); // redirect to IntroductionPage
    }
  }

  // Email & Password - Register
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Email & Password - Sign In
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Sign In with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      // throw 'Something went wrong. Please try again.';
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  // Forgot Password
  Future<void> sendEmailResetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Log Out
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const SigninPage());
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}