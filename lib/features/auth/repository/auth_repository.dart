// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/mobile_screen_layout.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  ///Get current state authentication
  Future<UserModel?> getCurrentUserData() async {
    final userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    if (userData.data() == null) return null;

    return UserModel.fromMap(userData.data()!);
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          print('auth repo - sign in with phone - verification completed');
          print(phoneAuthCredential);
          await auth.signInWithPhoneNumber(phoneNumber);
        },
        verificationFailed: (error) {
          print('auth repo - sign in with phone - verification failed');
          print(error.message);
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          print('auth repo - sign in with phone - code sent');
          print(verificationId);
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print('auth repo - sign in with phone - code auth retrieval timeout');
        },
      );
    } on FirebaseAuthException catch (e) {
      customShowSnackbar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      print('auth repo - verify OTP - try');
      print(verificationId);
      print(userOTP);
      // Credential get from Phone Number
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      // Credential get from any source like phone number, google, facebook, etc
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInformationScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      print('auth repo - verify OTP - catch');
      print(e.message);
      customShowSnackbar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required context,
  }) async {
    try {
      print('auth repo - verify OTP - try');
      String uid = auth.currentUser!.uid;
      String photoUrl = 'https://picsum.photos/200';
      print(uid);

      if (profilePic == null) return;

      print('auth repo - verify OTP - try - storeFileToFirebase');
      photoUrl = await ref
          .read(commonFirebaseStorageRepository)
          .storeFileToFirebase('profilePic/$uid', profilePic);

      print(photoUrl);

      final user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: auth.currentUser!.uid,
        groupId: [],
      );

      print(user.toString());

      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const MobileScreenLayout();
        },
      ), (route) => false);
    } catch (e) {
      print('auth repo - save user data to firebase - catch');
      print(e.toString());
      customShowSnackbar(context: context, content: e.toString());
    }
  }
}
