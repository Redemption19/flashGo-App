import 'package:driver_app/constants/app_utils.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/splashScreen/splash_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  String? selectedFile;

  List<String> carTypesList = ["uber-x", "uber-go", "bike"];
  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
      "driver_license":selectedFile,
    };
    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);


    Fluttertoast.showToast(msg: "Car Details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new,), onPressed: () { 
                     Navigator.of(context).pushNamed('/CarInfoScreen');
                     },
                  ),
                ],
              ),
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
                  "Vehicle Information",
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
                child: Column(
                  children: [
                    // Car Model Text Field
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller:
                          carModelTextEditingController, // Use the Car Model controller
                      style: const TextStyle(
                        color: colorPrimary,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: colorPrimary,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(
                          Icons.directions_car,
                          color: colorPrimary,
                        ),
                        hintText: 'Car Model',
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
                    SizedBox(height: 15.0), // Add spacing between fields

                    // Car Number Text Field
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller:
                          carNumberTextEditingController, // Use the Car Number controller
                      style: const TextStyle(
                        color: colorPrimary,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: colorPrimary,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(
                          Icons.confirmation_number,
                          color: colorPrimary,
                        ),
                        hintText: 'Car Number',
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
                    const SizedBox(height: 15.0), // Add spacing between fields

                    // Car Color Text Field
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller:
                          carColorTextEditingController, // Use the Car Color controller
                      style: const TextStyle(
                        color: colorPrimary,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: colorPrimary,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(
                          Icons.color_lens,
                          color: colorPrimary,
                        ),
                        hintText: 'Car Color',
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
                  ],
                ),
              ),
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

              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                iconSize: 26,
                dropdownColor: Colors.deepOrangeAccent,
                hint: const Text(
                  "Please choose Car or Motorcycle Type",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypesList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: const TextStyle(color: Colors.black),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (carColorTextEditingController.text.isNotEmpty &&
                      carNumberTextEditingController.text.isNotEmpty &&
                      carModelTextEditingController.text.isNotEmpty &&
                      selectedCarType != null && selectedFile != null)
                  {
                    saveCarInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                ),
                child: const Text(
                  "Save to Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}