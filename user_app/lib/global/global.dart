import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/models/direction_details_info.dart';
import 'package:user_app/models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId = "";
String cloudMessagingServerToken =
    "key=AAAAI7jFvTk:APA91bEkZj5YMlaOYK05gNGlsz2D31mfszX-JKKLt_erqzzgnNkWGcW3GZUmDe4r7g2YsrTLWI_sUAMtG2I7WcOkoy2EaBv3EFvQVs-hw9FYvWedIrRmpo4Qst4tX7VoKM3WQGZ7YFLa";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";