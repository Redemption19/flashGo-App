import 'package:driver_app/global/global.dart';
import 'package:driver_app/widgets/info_design_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  String? editedPhone;
  String? editedEmail;
  String? editedCarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar Image and Name
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/avatar.png'),
                ),
                SizedBox(height: 10), // Adjust the height as needed
                Text(
                  onlineDriverData.name!,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  titleStarsRating + " Driver",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.black,
                height: 2,
                thickness: 2,
              ),
            ),

            SizedBox(
              height: 38.0,
            ),

            //phone
            InfoDesignUIWidget(
              textTitle: "Phone Number", // Add your title text here
              textInfo: editedPhone ?? onlineDriverData.phone!,
              iconData: Icons.phone_iphone,
            ),

            InfoDesignUIWidget(
              textTitle: "Email", // Add your title text here
              textInfo: editedEmail ?? onlineDriverData.email!,
              iconData: Icons.email,
            ),

            InfoDesignUIWidget(
              textTitle: "Car Information", // Add your title text here
              textInfo: editedCarColor ??
                  (onlineDriverData.car_color ?? "") +
                      " " +
                      (onlineDriverData.car_model ?? "") +
                      " " +
                      (onlineDriverData.car_number ?? ""),
              iconData: Icons.car_repair,
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    // Handle Edit button press
                    await _editInformation(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Show a confirmation dialog before logging out
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Logout'),
                        content: Text('Are you sure you want to logout? 😔'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel',
                                style: TextStyle(color: Colors.black)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Perform logout and close app
                              fAuth.signOut();
                              SystemNavigator.pop();
                            },
                            child: Text('Logout',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                  ),
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editInformation(BuildContext context) async {
    // Display a dialog for editing information
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Information'),
        content: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                onChanged: (value) {
                  setState(() {
                    editedPhone = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    editedEmail = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Car Information'),
                onChanged: (value) {
                  setState(() {
                    editedCarColor = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Save', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
          ),
        ],
      ),
    );

    // If the user clicks Save in the dialog, update the information
    if (result == true) {
      // Update the information with edited values
      setState(() {
        onlineDriverData.phone = editedPhone;
        onlineDriverData.email = editedEmail;
        onlineDriverData.car_color = editedCarColor;
      });
    }
  }
}
