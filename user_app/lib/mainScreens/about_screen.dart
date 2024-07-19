import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AboutScreen extends StatefulWidget
{
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}




class _AboutScreenState extends State<AboutScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(

        children: [

          //image
           Container(
            height: 230,
            child: Center(
              child: Image.asset(
                "images/complogo.png",
                width: 260,
              ),
            ),
          ),

          Column(
            children: [

              //company name
              const Text(
                "FlashGo App",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //about you & your company - write some info
              const Text(
                "At FlashGo, we redefine your commuting experience with a commitment to speed, safety, and reliability, "
                "Our ride-hailing service is designed to make your journeys seamless, stress-free, and enjoyable. "
                "Fast Rides, Every Time, Safe and Secure, Transparent Pricing & User-Friendly App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "FlashGo takes pride in its lightning-fast response times. No more waiting endlessly for your ride, "
                    "Your safety is our top priority, "
                    "20M+ people already use this app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              //close
              ElevatedButton(
                onPressed: ()
                {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),

        ],

      ),
    );
  }
}
