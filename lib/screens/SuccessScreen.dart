import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/screens/landing_screen.dart';
import 'package:e_commerce_app/utils/media_query.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Success',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Your order has been placed successfully.',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 40.0),
            Image.asset(
              'assets/images/success.png', // assuming the image file is stored in the "assets/images" directory

              height: CustomMediaQuery(context).height * .6,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.btncolor,
                fixedSize: Size(CustomMediaQuery(context).width * .8, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LandingScreen(),
                  ),
                );
              },
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
