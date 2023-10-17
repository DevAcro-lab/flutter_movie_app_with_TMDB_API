import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/view/auth/reset_password.dart';

import '../../constants/colors.dart';
import '../../constants/widgets/custom_button.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key, required this.email}) : super(key: key);
  String email;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // FocusNode secondNode = FocusNode();
  // FocusNode thirdNode = FocusNode();
  // FocusNode forthNode = FocusNode();
  // FocusNode fifthNode = FocusNode();
  // FocusNode sixthNode = FocusNode();

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFifth = TextEditingController();

  String? otp;

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
              'OTP Verification',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 27,
              ),
            ),
            SizedBox(height: s.height * 0.02),
            Text(
              "6 digit code has been send to: ",
              style: TextStyle(
                fontSize: 17,
                color: AppColors.white.withOpacity(0.7),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.email,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: s.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                otpContainer(s, true, _fieldOne),
                otpContainer(s, false, _fieldTwo),
                otpContainer(s, false, _fieldThree),
                otpContainer(s, false, _fieldFour),
                otpContainer(s, false, _fieldFifth),
              ],
            ),
            SizedBox(height: s.height * 0.05),
            CustomButton(
                text: 'Verify',
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen(),
                    ),
                  );
                },
                width: double.infinity),
            SizedBox(height: s.height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't recieve the OTP? ",
                  style: TextStyle(
                    color: AppColors.forgotPassColor,
                  ),
                ),
                Text(
                  'Resend',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.white.withOpacity(0.7),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container otpContainer(
    final Size s,
    final bool autoFocus,
    final TextEditingController controller,
  ) {
    return Container(
      width: s.width * 0.14,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.otpContainerColor,
      ),
      child: Center(
        child: TextField(
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          controller: controller,
          style: TextStyle(
            color: AppColors.white.withOpacity(0.8),
            fontSize: 21,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          decoration: const InputDecoration(
            counterText: '',
            border: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
