import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_app/app_utlis.dart';
import 'package:user_app/authentication/google_signin.dart';
import 'package:user_app/authentication/login_screen.dart';
import 'package:user_app/authentication/password_reset.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/main_screen.dart';
import 'package:user_app/splashScreen/splash_screen.dart';
import 'package:user_app/widgets/progress_dialog.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  validateForm() {
    if (fullNameController.text.length < 3) {
      // Validation for full name
      Fluttertoast.showToast(
        msg: "Name must be at least 3 characters.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (!emailController.text.contains("@")) {
      // Validation for email
      Fluttertoast.showToast(
        msg: "Email address is not valid.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (phoneNumberController.text.isEmpty) {
      // Validation for phone number
      Fluttertoast.showToast(
        msg: "Phone number is required.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (passwordController.text.length < 6) {
      // Validation for password
      Fluttertoast.showToast(
        msg: "Password must be at least 6 characters.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Saving Please wait...",
          );
        });
    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      Map<String, dynamic> userMap = {
        "id": firebaseUser.uid,
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneNumberController.text.trim(),
      };

      DatabaseReference reference =
          FirebaseDatabase.instance.ref().child("users");
      reference.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Sign Up Successful Redirecting to Home Page, please wait....");
      Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Personal Information did not save.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo/app_logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0,
              ),
              const Center(
                child: Text(
                  "Register as a Passenger",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: fullNameController,
                  style: const TextStyle(
                    color: colorPrimary,
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: colorPrimary,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: colorPrimary,
                    ),
                    hintText: 'Full Name',
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
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType
                      .emailAddress, // Change keyboardType to email
                  controller:
                      emailController, // Change controller to 'emailController'
                  style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.email, // Change prefix icon to email icon
                      color: Colors.deepOrangeAccent,
                    ),
                    hintText: 'Email', // Change hintText to 'Email'
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
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  style: const TextStyle(
                    color: colorPrimary,
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: colorPrimary,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: colorPrimary,
                    ),
                    hintText: 'Phone Number',
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
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: true, // Hide password characters
                  style: const TextStyle(
                    color: colorPrimary,
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: colorPrimary,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: colorPrimary,
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
                padding: const EdgeInsets.only(left: 250.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PasswordResetScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity, // Make the button expand horizontally
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to HomeScreen when the button is pressed
                      validateForm();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: colorPrimary, // Set the background color
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
                  width: double.infinity, // Make the button expand horizontally
                  child: ElevatedButton(
                   onPressed: () async {
                          try {
                            final User? user = await signInWithGoogle();
                            if (user != null) {
                              // Handle the case where Google Sign-In was successful
                              // You can navigate to the next screen or perform other actions.
                             
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));

                              // Show a dialog to indicate login success
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Login Success'),
                                    content: const Text(
                                        'You have successfully logged in with Google.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Handle the case where Google Sign-In was canceled or failed
                              // You can show a message or handle it in another way.
                              // For example, show a snackbar with an error message:
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Google Sign-In was canceled or failed')),
                              );
                            }
                          } catch (e) {
                            // Handle any unexpected errors here (e.g., network issues, etc.)
                            // For example, show a snackbar with an error message:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('An error occurred: $e')),
                            );
                          }
                        },
                    style: ElevatedButton.styleFrom(
                      primary: colorPrimary, // Set the background color
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
                          size: 24, // Set the icon size
                        ),
                        SizedBox(
                            width: 10), // Add spacing between image and text
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
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an Account?  ",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                      children: [
                        TextSpan(
                          text: "Sign In Here",
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 18.0,
                            fontWeight:
                                FontWeight.bold, // Change link text color here
                            decoration:
                                TextDecoration.underline, // Add underline
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Add a Sign-Up Button here
            ],
          ),
        ),
      ),
    );
  }
}