import 'package:flutter/material.dart';
import 'package:movies_app/view/auth/auth_screen.dart';
import 'package:movies_app/view/auth/congrats_screen.dart';

import '../../constants/colors.dart';
import '../../constants/widgets/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController rePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reset Password?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 27,
              ),
            ),
            SizedBox(height: s.height * 0.02),
            Text(
              "Please enter your new password to update the password",
              style: TextStyle(
                fontSize: 17,
                color: AppColors.white.withOpacity(0.7),
              ),
            ),
            SizedBox(height: s.height * 0.05),
            TextFormField(
              controller: passController,
              decoration: const InputDecoration(
                hintText: 'Password',
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  size: 19,
                ),
              ),
            ),
            SizedBox(height: s.height * 0.05),
            TextFormField(
              controller: rePassController,
              decoration: const InputDecoration(
                hintText: 'Confirm new password',
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  size: 19,
                ),
              ),
            ),
            SizedBox(height: s.height * 0.05),
            CustomButton(
              text: 'Reset Password',
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CongratsScreen(),
                  ),
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
