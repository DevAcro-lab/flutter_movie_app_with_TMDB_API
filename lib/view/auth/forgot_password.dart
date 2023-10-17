import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/view/auth/otp_screen.dart';

import '../../constants/widgets/custom_button.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forgot Password?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 27,
              ),
            ),
            SizedBox(height: s.height * 0.02),
            Text(
              "You forgot your password? don't worry, please enter your recovery email address",
              style: TextStyle(
                fontSize: 17,
                color: AppColors.white.withOpacity(0.7),
              ),
            ),
            SizedBox(height: s.height * 0.05),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email Address'),
            ),
            SizedBox(height: s.height * 0.05),
            CustomButton(
              text: 'Submit',
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        OTPScreen(email: emailController.text),
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
