import 'package:flutter/material.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/image23.png',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 35),
            const Text(
              "Oops! Order Failed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff181725),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Something went terribly wrong.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff7C7C7C),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff53B175),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Please Try Again",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () => Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ),
                child: const Text(
                  "Back to home",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff181725),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}