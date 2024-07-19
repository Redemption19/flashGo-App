import 'package:flutter/material.dart';

class InfoDesignUIWidget extends StatelessWidget {
  final String? textInfo;
  final IconData? iconData;
  final String? textTitle;

  const InfoDesignUIWidget({Key? key, this.textInfo, this.iconData, this.textTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                 padding: const EdgeInsets.only(left: 30.0), 
                child: Text(
                  textTitle!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 18, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Customize border radius here
                  side: BorderSide(
                    color: Colors.deepOrangeAccent, // Customize border color here
                    width: 1, // Customize border width here
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    iconData,
                    color: Colors.black,
                  ),
                  title: Text(
                    textInfo!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
