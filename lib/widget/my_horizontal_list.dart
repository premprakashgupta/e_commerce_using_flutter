import 'package:e_commerce_app/utils/media_query.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyHorizontalList extends StatelessWidget {
  const MyHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    double size = CustomMediaQuery(context).width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: size * .62,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // assuming 10 items in the list
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: size * .3,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: size * .331,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .015),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/limited-edition-2022-fashion-poster-design-template-85333b27411fceea83c3a8e9617eedf4_screen.jpg?ts=1646817870"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const ParaText(
                          text: '20% OFF',
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        alignment: Alignment.center,
                        width: size * .08,
                        height: size * .08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(size * .04),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            size: size * .04,
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size * .2,
                          child: RatingBar.builder(
                            itemSize: size * .02,
                            ignoreGestures: true,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        const SizedBox(width: 4),
                        ParaText(
                          text: '4.5',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const ParaText(
                      text: 'Drothy Perkins',
                      color: Colors.black38,
                    ),
                    const SizedBox(height: 8),
                    const SubHeadingText(
                      text: 'Evening Dresses',
                      color: Colors.black,
                    ),
                    const ParaText(
                      text: '\$4.5',
                      fontweight: FontWeight.w700,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
