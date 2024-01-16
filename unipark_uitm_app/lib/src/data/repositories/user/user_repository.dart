import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/features/core/models/user_model.dart';
import 'package:unipark_uitm_app/src/data/repositories/exceptions/firebase_auth_exception.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // Firebase Firestore DB
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  // Firebase Realtime DB
  // final FirebaseDatabase _dbRealTime = FirebaseDatabase.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _dbFirestore.collection("Users").doc(user.id).set(user.toJson());
      // await _dbRealTime.ref().child("Users").child(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<UserModel> fetchUserInformation() async {
    try {
      final documentSnapshot = await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> updateUserInformation(UserModel updateUser) async {
    try {
      await _dbFirestore.collection("Users").doc(updateUser.id).update(updateUser.toJson());
      // await _dbRealTime.ref().child("Users").child(updateUser.id).update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
      // await _dbRealTime.ref().child("Users").child(AuthenticationRepository.instance.authUser!.uid).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _dbFirestore.collection("Users").doc(userId).delete();
      // await _dbRealTime.ref().child("Users").child(userId).remove();
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}