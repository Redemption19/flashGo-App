import 'package:driver_app/infoHandler/app_info.dart';
import 'package:driver_app/mainScreens/trips_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({Key? key}) : super(key: key);

  @override
  _EarningsTabPageState createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          //earnings
          Container(
            color: Colors.red,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  const Text(
                    "Your Earnings:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "GH₵ " +
                        Provider.of<AppInfo>(context, listen: false)
                            .driverTotalEarnings,
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //total number of trips
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => TripsHistoryScreen()));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Background color
              elevation: 4, // Elevation
              side: BorderSide(color: Colors.black, width: 2), // Border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Border radius
              ),
              shadowColor: Colors.grey, // Shadow color
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Image.asset(
                    "images/ubercar.png",
                    width: 100,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Trips Completed",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        Provider.of<AppInfo>(context, listen: false)
                            .allTripsHistoryInformationList
                            .length
                            .toString(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
