import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/authentication/presentation/pages/welcome_page.dart';
import 'package:unipark_uitm_app/src/features/core/presentation/pages/home_page.dart';
import 'package:unipark_uitm_app/src/repository/authentication_repository/exceptions/register_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomePage()) : Get.offAll(() => const HomePage());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const HomePage()) : Get.to(() => const WelcomePage());
    } on FirebaseAuthException catch(e) {
      final ex = RegisterWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = RegisterWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
    } catch (_) {
    }
  }

  Future<void> logout() async => await _auth.signOut();
}