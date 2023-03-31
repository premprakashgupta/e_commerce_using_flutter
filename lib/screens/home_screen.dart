import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/utils/media_query.dart';

import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/my_horizontal_list.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/limited-edition-2022-fashion-poster-design-template-85333b27411fceea83c3a8e9617eedf4_screen.jpg?ts=1646817870"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: CustomMediaQuery(context).width * .5,
                        child: HeadingText(
                          text: 'Fashion Sale',
                          size: MediaQuery.of(context).size.width * 0.11,
                          fontweight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ParaText(
                      text: "Sale",
                      fontweight: FontWeight.bold,
                      size: 48,
                    ),
                    ParaText(
                      text: "view all",
                      size: 16,
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SubHeadingText(
                    text: "Super summer sale",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyHorizontalList()
              ],
            ),
          )
        ]),
      ),
    );
  }
}
