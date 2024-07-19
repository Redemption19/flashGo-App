import 'package:flutter/material.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainScreens/about_screen.dart';
import 'package:user_app/mainScreens/language_setting.dart';
import 'package:user_app/mainScreens/profile_screen.dart';
import 'package:user_app/mainScreens/sos_action_screen.dart';
import 'package:user_app/mainScreens/trips_history_screen.dart';
import 'package:user_app/splashScreen/splash_screen.dart';

class MyDrawer extends StatefulWidget {
  String? name;
  String? email;

  MyDrawer({super.key, this.name, this.email});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // drawer header
          Container(
            height: 165,
            color: Colors.yellow,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.red),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 12.0,
          ),

          // drawer body
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => TripsHistoryScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.black,
              ),
              title: Text(
                "History",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => ProfileScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text(
                "Visit Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => AboutScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.black,
              ),
              title: Text(
                "About",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => LanguageScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.black,
              ),
              title: Text(
                "Language Settings",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              // Show alert dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Sign Out"),
                    content: Text("Are you sure you want to sign out?😢"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog and sign out if confirmed
                          Navigator.of(context).pop();
                          fAuth.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const MySplashScreen()));
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Close the dialog if canceled
                          Navigator.of(context).pop();
                        },
                        child: Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          

          // SOS button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SOSActionScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0), // Adjust the horizontal padding as needed
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(8.0), // Adjust the value as needed
                  border: Border.all(color: Colors.red), // Border color
                ),
                child: const ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "🚨",
                        style: TextStyle(
                            fontSize:
                                20), // Adjust the size of the emoji as needed
                      ),
                      SizedBox(
                          width:
                              8), // Adjust the space between the emoji and the icon as needed
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  title: Text(
                    "SOS",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Adjust the font size as desired
                      letterSpacing:
                          1.5, // Adjust the spacing between letters as desired
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
