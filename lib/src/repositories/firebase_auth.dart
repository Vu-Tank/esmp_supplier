import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> verifyPhone(
      {required String phoneNumber,
      required Function onSuccess,
      required Function onFailed}) async {
    try {
      await _auth.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          onFailed(error.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          log('ok pass');
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      onFailed(e.toString());
    }
  }
}
