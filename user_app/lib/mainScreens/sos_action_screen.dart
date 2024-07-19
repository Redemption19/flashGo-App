import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSActionScreen extends StatelessWidget {
  const SOSActionScreen({Key? key}) : super(key: key);

  final String _phoneNumber = "911";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Actions'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Select an action below to send an emergency alert to the respective contact. Stay safe!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final call = 'tel:$_phoneNumber';
              final text = 'sms:$_phoneNumber';
              if(await canLaunch(text)) {
                await launch(text);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Send Emergency to Police',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Send Emergency to Family',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Send Emergency to Friend',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
