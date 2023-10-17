import 'package:flutter/material.dart';
import 'package:movies_app/view/auth/auth_screen.dart';

import '../../constants/colors.dart';
import '../../constants/widgets/custom_button.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Congrats!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 27,
              ),
            ),
            SizedBox(height: s.height * 0.02),
            Text(
              "Congrats your password has been updated please continue to login",
              style: TextStyle(
                fontSize: 17,
                color: AppColors.white.withOpacity(0.7),
              ),
            ),
            SizedBox(height: s.height * 0.06),
            CustomButton(
                text: 'Login',
                onPress: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => AuthScreen(),
                      ),
                      (route) => false);
                },
                width: double.infinity),
          ],
        ),
      ),
    );
  }
}
