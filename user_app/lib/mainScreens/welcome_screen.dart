import 'package:flutter/material.dart';
import 'package:user_app/authentication/login_screen.dart';
import 'package:user_app/authentication/signup_screen.dart';
import 'package:user_app/constants/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .60,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstants.welcomePicture),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: const Text(
                      AppConstants.discoverText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: const Text(
                      AppConstants.descriptionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 120,
            // color: Colors.amber,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: Colors.deepOrangeAccent,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the Sign Up screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: _buildButton(
                          title: AppConstants.registerText,
                          color: Colors.deepOrangeAccent),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the Sign In screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: _buildButton(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildButton({String? title, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color ?? Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Text(
          title ?? "Sign In",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
