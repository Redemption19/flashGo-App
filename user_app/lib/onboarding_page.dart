import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:user_app/mainScreens/welcome_screen.dart';



class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {
          // print('skipped');
        },
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
          // print('done tapped');
        },
        onBoardData: onBoardData,
        titleStyles: const TextStyle(
          color: Colors.deepOrange,
          fontSize: 30,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Colors.deepOrangeAccent,
          activeColor: Colors.deepOrange,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
            // print('skipButton pressed');
          },
          child: const Text(
            "Skip",
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        // nextButton: OnBoardConsumer(
        //   builder: (context, ref, child) {
        //     final state = ref.watch(onBoardStateProvider);
        //     return InkWell(
        //      onTap: () {
        //         if (state.isLastPage) {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        //           );
        //         } else {
        //           _onNextTap(state);
        //         }
        //       },
        //       child: Container(
        //         width: 230,
        //         height: 50,
        //         alignment: Alignment.center,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(30),
        //           gradient: const LinearGradient(
        //             colors: [Colors.redAccent, Colors.deepOrangeAccent],
        //           ),
        //         ),
        //         child: Text(
        //           state.isLastPage ? "Done" : "Next",
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //print("nextButton pressed");
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Versatility",
    description:
        "Depending on the location, time of day, and personal preference, having the option to choose between a motorcycle or a taxi can provide versatility in transportation.",
    imgUrl: "assets/images/car_motor1.png",
  ),
  const OnBoardModel(
    title: "Convenience way to your destination!",
    description:
        "Booking a motorcycle or a taxi provides a convenient and efficient way to get around, without the need to worry about finding parking or navigating through traffic.",
    imgUrl: 'assets/images/car_motor3.png',
  ),
  const OnBoardModel(
    title: "Cost-effective transportation and Faster commute",
    description:
        "More fuel-efficient, cost-effective option for transportation, You save your money in the long run. Navigate through traffic more easily, which can help you reach your destination faster, especially in busy urban areas.",
    imgUrl: 'assets/images/pick_taxi.png',
  ),
];
