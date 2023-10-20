/*import 'package:flutter/material.dart';
import 'package:logging/core/utils/facebookSignin.dart';

import '../constants.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await signInWithFacebook(context);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.blue,
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
            'Sign in with Facebook',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 40),
          Container(
            height: 50,
            width: 50,
            color: Colors.transparent,
            child: Image.asset(kFacebookLogo),
          ),
        ],
      ),
    );
  }
}
*/