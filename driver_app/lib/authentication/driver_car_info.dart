import 'package:driver_app/authentication/car_info_screen.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/widgets/progress_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class DriverCarInfor extends StatefulWidget {
  const DriverCarInfor({Key? key}) : super(key: key);

  @override
  State<DriverCarInfor> createState() => _DriverCarInforState();
}

class _DriverCarInforState extends State<DriverCarInfor> {
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController licenseExpirationController = TextEditingController();
  TextEditingController scannedCopyController = TextEditingController();
  TextEditingController ghanaCardNumberController = TextEditingController();
  String? selectedFile;

  void saveDriverLicenseNow() async {
  if (licenseNumberController.text.isEmpty ||
      licenseExpirationController.text.isEmpty ||
      scannedCopyController.text.isEmpty ||
      ghanaCardNumberController.text.isEmpty) {
    Fluttertoast.showToast(
      msg: "All driver information fields are required.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "Saving Personal info, Please wait...",
        );
      },
    );
    
      Map<String, dynamic> driverMap = {
        "licenseNumber": licenseNumberController.text.trim(),
        "licenseExpiration": licenseExpirationController.text.trim(),
        "scannedCopy": scannedCopyController.text.trim(),
        "ghanaCardNumber": ghanaCardNumberController.text.trim(),
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(currentFirebaseUser!.uid).set(driverMap);

      Fluttertoast.showToast(
          msg: "License Info Saved, proceeding.....");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
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
              // Your screen title and logo here
              Center(
                child: Image.asset(
                  'assets/images/logo/app_logo.png', // Adjust image path
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Identity Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Driver's Licence Number Input
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: licenseNumberController,
                  style: const TextStyle(
                    color: Colors.black, // Adjust text color as needed
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: Colors.black, // Adjust cursor color as needed
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.idCard, // Adjust icon as needed
                      color: Colors.black, // Adjust icon color as needed
                    ),
                    hintText: "Driver's Licence Number",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
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

              // Driver's Licence Expiration Date Input (You can use a Date Picker here)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: licenseExpirationController,
                  style: const TextStyle(
                    color: Colors.black, // Adjust text color as needed
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: Colors.black, // Adjust cursor color as needed
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.calendar_today, // Adjust icon as needed
                      color: Colors.black, // Adjust icon color as needed
                    ),
                    hintText: "Driver's Licence Expiration Date",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
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

              // Scanned Copy of Driver's License Input (You can use an Image Picker here)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Check if permission is granted
                    var status = await Permission.storage.status;
                    if (status.isGranted) {
                      // Permission is granted, proceed with file selection
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                      );

                      if (result != null) {
                        PlatformFile file = result.files.first;
                        setState(() {
                          selectedFile =
                              file.name; // Update the selected file name
                        });
                      } else {
                        // User canceled the file selection
                      }
                    } else {
                      // Permission is not granted, request permission
                      if (status.isPermanentlyDenied) {
                        // User has denied permission permanently, navigate to app settings
                        openAppSettings();
                      } else {
                        // Request permission
                        var requestResult = await Permission.storage.request();
                        if (requestResult.isGranted) {
                          // Permission granted, proceed with file selection
                          // You can also handle the case when the user denies the request
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent, // Button background color
                    onPrimary: Colors.white, // Text color
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0), // Adjust padding as needed
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5.0), // Button border radius
                      side: BorderSide(
                          color: Colors.deepOrangeAccent
                              .withOpacity(0.7)), // Border color
                    ),
                  ),
                  child: Text(
                    selectedFile != null
                        ? "Selected File: $selectedFile"
                        : "Select Scanned Copy of Driver's License",
                    style: TextStyle(
                      color: selectedFile != null ? Colors.white : Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),

              // Ghana Card Number Input
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: ghanaCardNumberController,
                  style: const TextStyle(
                    color: Colors.black, // Adjust text color as needed
                    fontFamily: 'Montserrat',
                  ),
                  cursorColor: Colors.black, // Adjust cursor color as needed
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.idCard, // Adjust icon as needed
                      color: Colors.black, // Adjust icon color as needed
                    ),
                    hintText: "Ghana Card Number",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
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

              // Sign Up Button (Navigation to HomeScreen)
              Padding(
                padding: const EdgeInsets.only(left: 260.0),
                child: FloatingActionButton(
                  onPressed: () {
                    if (licenseNumberController.text.isNotEmpty &&
                        licenseExpirationController.text.isNotEmpty &&
                        scannedCopyController.text.isNotEmpty &&
                        ghanaCardNumberController.text.isNotEmpty &&
                        selectedFile != null) {
                      saveDriverLicenseNow();
                    }
                  },
                  backgroundColor: Colors.deepOrangeAccent,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}