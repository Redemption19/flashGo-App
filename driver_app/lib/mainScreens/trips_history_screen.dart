import 'package:driver_app/infoHandler/app_info.dart';
import 'package:driver_app/widgets/history_design_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class TripsHistoryScreen extends StatefulWidget {
  @override
  State<TripsHistoryScreen> createState() => _TripsHistoryScreenState();
}

class _TripsHistoryScreenState extends State<TripsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Trips History",
          style: TextStyle(color: Colors.white),
        ),
        leading: Container(
          margin: const EdgeInsets.all(9.0), // Adjust the margin as needed
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // Replace with your desired color
          ),
          child: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.red, // Replace with your desired icon color
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, i) => const Divider(
          color: Colors.red,
          thickness: 2,
          height: 2,
        ),
        itemBuilder: (context, i) {
          return Card(
            color: Colors.white,
            child: HistoryDesignUIWidget(
              tripsHistoryModel: Provider.of<AppInfo>(context, listen: false)
                  .allTripsHistoryInformationList[i],
            ),
          );
        },
        itemCount: Provider.of<AppInfo>(context, listen: false)
            .allTripsHistoryInformationList
            .length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
