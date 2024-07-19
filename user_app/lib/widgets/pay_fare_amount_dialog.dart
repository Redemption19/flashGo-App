import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/mainScreens/payment_screen.dart';

class PayFareAmountDialog extends StatefulWidget {
  double? fareAmount;

  PayFareAmountDialog({super.key, this.fareAmount});

  @override
  State<PayFareAmountDialog> createState() => _PayFareAmountDialogState();
}

class _PayFareAmountDialogState extends State<PayFareAmountDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(6),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Total Fare Amount".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 4,
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.fareAmount.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "This is the total trip fare amount, Please Pay it to the driver.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    Navigator.pop(context, "cashPayed");
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Pay Cash",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "GH₵  " + widget.fareAmount!.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Adjust color as needed
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentScreen()),
                  );
                },
                child: const Text(
                  "Pay with Card",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
