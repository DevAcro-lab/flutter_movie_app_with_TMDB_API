import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/provider/get_account_id_notifier.dart';
import 'package:movies_app/view/auth/forgot_password.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/widgets/custom_button.dart';
import '../../constants/widgets/persistent_navigator.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GetAccountIdNotifier getAccountIdNotifier = GetAccountIdNotifier();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: s.height * 0.05),
              const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              SizedBox(height: s.height * 0.07),
              TextFormField(
                controller: usernameController,
                style: const TextStyle(
                  color: AppColors.forgotPassColor,
                ),
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              SizedBox(height: s.height * 0.05),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(
                    Icons.visibility_off_outlined,
                    size: 19,
                  ),
                ),
              ),
              SizedBox(height: s.height * 0.03),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.forgotPassColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: s.height * 0.03),
              CustomButton(
                text: 'Login',
                width: double.infinity,
                onPress: () async {
                  final username = usernameController.text;
                  final password = passwordController.text;
                  getAccountIdNotifier
                      .getAccountIdNotifier(username, password)
                      .then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const PersistentNavigator(),
                          ),
                        ),
                      )
                      .onError((error, stackTrace) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            alignment: Alignment.centerLeft,
                            actions: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: const BoxDecoration(
                                  color: AppColors.forgotPassColor,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Something went wrong",
                                  style: TextStyle(fontSize: 17),
                                )),
                              ),
                              SizedBox(height: s.height * 0.03),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "Please first Sign up on TMDB website, then you can enter your username and password here to continue"),
                              ),
                              SizedBox(height: s.height * 0.04),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Go Back')),
                                ),
                              ),
                            ],
                          );
                        });
                  });
                },
              ),
              SizedBox(height: s.height * 0.1),
              RichText(
                text: TextSpan(
                    text: "Before Logging in here, Please ",
                    children: [
                      TextSpan(
                          text: "Sign Up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              const uri = "https://www.themoviedb.org/signup";
                              if (await canLaunchUrl(Uri.parse(uri))) {
                                await launchUrl(Uri.parse(uri));
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Sorry $uri is not currently working, please try again later'),
                                  ),
                                );
                              }
                            },
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline)),
                      const TextSpan(
                          text:
                              " on TMDB website first. then you can use it's username and password to continue here."),
                    ]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: s.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
