import 'package:driver_app/authentication/passwor_reset.dart';
import 'package:driver_app/authentication/signup_screen.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/splashScreen/splash_screen.dart';
import 'package:driver_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedLanguage = 'English'; // Initial language selection

  validateForm() {
    if (!emailController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required.");
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if(firebaseUser != null)
    {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey)
      {
        final snap = driverKey.snapshot;
        if(snap.value != null)
        {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.language,
                          color: Colors.deepOrangeAccent,
                        ),
                        const SizedBox(width: 8.0),
                        DropdownButton<String>(
                          value: selectedLanguage,
                          onChanged: (value) {
                            // Handle language selection here
                            setState(() {
                              selectedLanguage = value!;
                            });
                          },
                          items: ['English', 'Twi', 'French']
                              .map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(language),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo/app_logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Sign in as a Passenger",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      keyboardType: TextInputType
                          .emailAddress, // Change keyboardType to email
                      controller:
                          emailController, // Assuming you have an emailController
                      style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(
                          Icons.email, // Change the icon to email
                          color: Colors.deepOrangeAccent,
                        ),
                        hintText: 'Email', // Change "Full Name" to "Email"
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Montserrat',
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent.withOpacity(0.7),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: true, // Hide password characters
                      style: const TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.deepOrangeAccent,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Montserrat',
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent.withOpacity(0.7),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 250.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PasswordResetScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: double
                          .infinity, // Make the button expand horizontally
                      child: ElevatedButton(
                        onPressed: () {
                          validateForm();

                          // Handle sign-in logic here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .deepOrangeAccent, // Replace with your desired background color
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text("---------------- OR ------------------"),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: double
                          .infinity, // Make the button expand horizontally
                      child: ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .deepOrangeAccent, // Replace with your desired background color
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.yellowAccent, // Set the icon color
                              size: 20, // Set the icon size
                            ),
                            SizedBox(
                                width:
                                    10), // Add spacing between image and text
                            Text(
                              "Sign Up with Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () {
                        // Navigate to the SignUpScreen when the link is clicked
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Do not have an Account?  ",
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                          children: [
                            TextSpan(
                              text: "Sign up Here",
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 18.0,
                                fontWeight: FontWeight
                                    .bold, // Change link text color here
                                decoration:
                                    TextDecoration.underline, // Add underline
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
