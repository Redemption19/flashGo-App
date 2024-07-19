import 'package:driver_app/authentication/car_info_screen.dart';
import 'package:driver_app/constants/app_utils.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? gender;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ghanaCardController = TextEditingController();

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
    } else if (gender == null || gender!.isEmpty) {
      // Validation for gender
      Fluttertoast.showToast(
        msg: "Gender is required.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (ghanaCardController.text.isEmpty) {
      // Validation for Ghana Card
      Fluttertoast.showToast(
        msg: "Ghana Card is required.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async {
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
      Map<String, dynamic> driverMap = {
        "id": firebaseUser.uid,
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneNumberController.text.trim(),
        "gender": gender,
        "ghanaCard": ghanaCardController.text.trim(), // Include Ghana Card
      };

      DatabaseReference driversRef =
      FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(
          msg: "Processing, please wait....");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.0,
              // ),
              const Center(
                child: Text(
                  "Personal Information",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                  keyboardType:
                      TextInputType.emailAddress, // Change keyboardType
                  controller: emailController, // Use an email controller
                  style: const TextStyle(
                    color: colorPrimary,
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: colorPrimary,
                  // Add email validation logic
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.email, // Use an email icon
                      color: colorPrimary,
                    ),
                    hintText: 'Email',
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
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
              // Add Ghana Card text field
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: ghanaCardController, // Use Ghana Card controller
                  style: const TextStyle(
                    color: colorPrimary,
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: colorPrimary,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.credit_card, // Use an appropriate icon
                      color: colorPrimary,
                    ),
                    hintText: 'Ghana Card',
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
                child: DropdownButtonFormField<String>(
                  value: gender,
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: colorPrimary,
                    ),
                    labelText: 'Gender',
                    labelStyle: TextStyle(
                      color: Colors.deepOrangeAccent.withOpacity(0.7),
                      fontFamily: 'Montserrat',
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrangeAccent,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              //Positioned Floating Button
              Padding(
                padding: const EdgeInsets.only(left: 260.0),
                child: FloatingActionButton(
                  onPressed: () {
                    validateForm();
                  },
                  backgroundColor: Colors.deepOrangeAccent,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward),
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
