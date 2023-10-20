/*import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/homePage.dart';

Future<void> signInWithFacebook(BuildContext context) async {
  try {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(/*userCredential: userCredential*/),
      ),
    );
  } catch (e) {
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print(e);
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
  }
}
*/