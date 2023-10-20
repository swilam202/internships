import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../core/utils/googleSignin.dart';


class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
         await signInWithGoogle(context);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color.fromRGBO(67, 132, 241, 1.0),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(8),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sign in with Google',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 40),
          Container(
            height: 50,
            width: 50,
            color: Colors.white,
            child: Image.asset(kGoogleLogo),
          ),
        ],
      ),
    );
  }
}
