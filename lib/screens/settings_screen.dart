import 'package:flutter/material.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

import '../resources/auth_methods.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage:
                NetworkImage(_authMethods.currentUserData.photoURL!),
          ),
          const SizedBox(height: 10),
          Text(
            _authMethods.currentUserData.displayName!,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _authMethods.currentUserData.email!,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 50),
          CustomButton(
            text: 'Log Out',
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              _authMethods.signOut();
            },
          ),
        ],
      ),
    );
  }
}
