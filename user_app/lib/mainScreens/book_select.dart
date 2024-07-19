import 'package:flutter/material.dart';

class SelectBooking extends StatefulWidget {
  SelectBooking({Key? key}) : super(key: key);

  @override
  State<SelectBooking> createState() => _SelectBookingState();
}

class _SelectBookingState extends State<SelectBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
           child: Container(
              decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                ),
                boxShadow:
                [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 18,
                    spreadRadius: .5,
                    offset: Offset(0.6, 0.6),
                  ),
                ],
            )
          )
         ),
        ],
      ),
    );
  }
}