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
    double size = CustomMediaQuery(context).width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: CustomMediaQuery(context).height * 0.7,
            width: size,
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
                  left: size * .05,
                  bottom: 0.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size * .5,
                        child: HeadingText(
                          text: 'Fashion Sale',
                          size: size * 0.11,
                          fontweight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: size * .05),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size * .10,
          ),
          Padding(
            padding: EdgeInsets.all(size * .03),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ParaText(
                      text: "Sale",
                      fontweight: FontWeight.bold,
                      size: size * 0.11,
                    ),
                    ParaText(
                      text: "view all",
                      size: size * .03,
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SubHeadingText(
                    text: "Super summer sale",
                  ),
                ),
                SizedBox(
                  height: size * .07,
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
