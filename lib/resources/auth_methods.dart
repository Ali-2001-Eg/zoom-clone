import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

// Sign in with Google and add user to Firestore

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User get currentUserData => _auth.currentUser!;

  // Stream of the current user
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in with Google and add user to Firestore
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool isSignedIn = false;
    try {
      // Sign in with Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with credentials
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (kDebugMode) {
          print("User: $user");
        }


          if (userCredential.additionalUserInfo!.isNewUser) {
            // Add user to Firestore
            await _firestore.collection('users').doc(user!.uid).set({
              'name': user.displayName,
              'profilePhoto': user.photoURL,
              'uid': user.uid,
            });
          }
          isSignedIn = true;

      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      isSignedIn = false;
    }
    return isSignedIn;
  }

  // Sign out
  signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
