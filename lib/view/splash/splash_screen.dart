import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies_app/constants/api_key.dart';
import 'package:movies_app/provider/user_preferences_notifier.dart';
import 'package:movies_app/view/auth/auth_screen.dart';
import 'package:movies_app/view/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkSessionAndLaunch();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const AuthScreen(),
          ),
          (route) => false);
    });
  }

  // Future<void> checkSessionAndLaunch() async {
  //   final sessionId = await UserPreferences.getSessionId();
  //
  //   if (sessionId != null) {
  //     final success = await performAutomaticLogin(sessionId);
  //     if (success) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => const HomeScreen()));
  //     } else {
  //       print("Session ID is null");
  //       null;
  //     }
  //   }
  // }

  // Future<bool> performAutomaticLogin(String sessionId) async {
  //   try {
  //     const validateUrl =
  //         'https://api.themoviedb.org/3/authentication/session/validate_with_login';
  //     const apiKey = ApiKey.apiKey;
  //
  //     final response = await http.post(
  //       Uri.parse('$validateUrl?api_key=$apiKey&session_id=$sessionId'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Session is valid, the user is successfully logged in
  //       final responseData = json.decode(response.body);
  //       print(responseData);
  //       // Extract user details or any necessary information from responseData
  //       // You might want to store this data for the user's session
  //       // Example: UserPreferences.storeUserData(responseData);
  //
  //       return true;
  //     } else {
  //       // Session is invalid or the automatic login failed
  //       // Handle the failure appropriately
  //       print("Status Code: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (error) {
  //     print(error);
  //     // Handle any exceptions or errors
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffDE0B30),
      body: Center(
        child: SizedBox(
          width: s.width * 0.2,
          height: s.height * 0.14,
          child: const Image(
            image: AssetImage('images/logo.png'),
          ),
        ),
      ),
    );
  }
}
