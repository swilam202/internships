import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.userCredential,
  });

  final UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(204, 204, 204, 1.0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(userCredential.user!.photoURL ?? ''),
                onBackgroundImageError: (object, stackTrace) =>
                    const Icon(Icons.error),
                radius: 60,
              ),
              const SizedBox(height: 15),
              Text(
                userCredential.user!.displayName ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                userCredential.user!.email ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
