import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:user_app/global/global.dart';


class RateDriverScreen extends StatefulWidget
{
  String? assignedDriverId;

  RateDriverScreen({super.key, this.assignedDriverId});

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}




class _RateDriverScreenState extends State<RateDriverScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(6),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 22.0,),

              const Text(
                "Rate Trip Experience",
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),

              const SizedBox(height: 22.0,),

              const Divider(height: 4.0, thickness: 4.0,),

              const SizedBox(height: 22.0,),

              SmoothStarRating(
                rating: countRatingStars,
                allowHalfRating: false,
                starCount: 5,
                color: Colors.yellow,
                borderColor: Colors.yellow,
                size: 46,
                onRatingChanged: (valueOfStarsChoosed)
                {
                  countRatingStars = valueOfStarsChoosed;

                  if(countRatingStars == 1)
                  {
                    setState(() {
                      titleStarsRating = "Very Bad";
                    });
                  }
                  if(countRatingStars == 2)
                  {
                    setState(() {
                      titleStarsRating = "Bad";
                    });
                  }
                  if(countRatingStars == 3)
                  {
                    setState(() {
                      titleStarsRating = "Good";
                    });
                  }
                  if(countRatingStars == 4)
                  {
                    setState(() {
                      titleStarsRating = "Very Good";
                    });
                  }
                  if(countRatingStars == 5)
                  {
                    setState(() {
                      titleStarsRating = "Excellent";
                    });
                  }
                },
              ),

              const SizedBox(height: 12.0,),

              Text(
                titleStarsRating,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),

              const SizedBox(height: 18.0,),
              
              ElevatedButton(
                  onPressed: ()
                  {
                    DatabaseReference rateDriverRef = FirebaseDatabase.instance.ref()
                        .child("drivers")
                        .child(widget.assignedDriverId!)
                        .child("ratings");

                    rateDriverRef.once().then((snap)
                    {
                      if(snap.snapshot.value == null)
                      {
                        rateDriverRef.set(countRatingStars.toString());

                        Navigator.of(context).popUntil(ModalRoute.withName('/mainScreen'));
                      }
                      else
                      {
                        double pastRatings = double.parse(snap.snapshot.value.toString());
                        double newAverageRatings = (pastRatings + countRatingStars) / 2;
                        rateDriverRef.set(newAverageRatings.toString());

                        SystemNavigator.pop();
                      }

                      Fluttertoast.showToast(msg: "Please Restart App Now");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    padding: const EdgeInsets.symmetric(horizontal: 74),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
              ),

              const SizedBox(height: 10.0,),

            ],
          ),
        ),
      ),
    );
  }
}
