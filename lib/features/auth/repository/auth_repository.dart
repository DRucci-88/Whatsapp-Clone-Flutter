// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';

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
      customShowSnackbar(context: context, content: e.message!);
    }
  }
}
