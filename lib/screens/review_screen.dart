import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/utils/media_query.dart';
import 'package:e_commerce_app/widget/bottom_modal_sheet.dart';

import 'package:e_commerce_app/widget/expandable_text.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    super.key,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<Review> reviews = [
    Review(
      name: "John Doe",
      profilePic: "https://picsum.photos/536/354",
      rating: 4,
      review:
          "Great product, very satisfied with my purchase.Great product, very satisfied with my purchase.Great product, very satisfied with my purchase.Great product, very satisfied with my purchase.Great product, very satisfied with my purchase.Great product, very satisfied with my purchase.Great product, very satisfied with my purchase.",
      likes: 10,
      dislikes: 2,
      date: "March 23, 2022",
    ),
    Review(
      name: "Jane Smith",
      profilePic: "https://picsum.photos/536/354",
      rating: 3,
      review: "Product was okay, nothing special.",
      likes: 5,
      dislikes: 3,
      date: "March 22, 2022",
    ),
    Review(
      name: "Bob Johnson",
      profilePic: "https://picsum.photos/536/354",
      rating: 5,
      review: "Amazing product, would highly recommend.",
      likes: 20,
      dislikes: 0,
      date: "March 21, 2022",
    ),
    Review(
      name: "John Doe",
      profilePic: "https://picsum.photos/536/354",
      rating: 4,
      review:
          "I had a great experience shopping on this app. The interface was easy to navigate and the checkout process was quick and hassle-free.",
      likes: 12,
      dislikes: 2,
      date: "March 10, 2022",
    ),
    Review(
      name: "Sarah Smith",
      profilePic: "https://picsum.photos/536/354",
      rating: 3,
      review:
          "Overall, I had a decent experience with this app. However, I did have some trouble finding the product I was looking for and had to do some extra searching.",
      likes: 5,
      dislikes: 1,
      date: "February 27, 2022",
    ),
    Review(
      name: "Michael Brown",
      profilePic: "https://picsum.photos/536/354",
      rating: 5,
      review:
          "This app is amazing! The selection of products is top-notch and the prices are unbeatable. I will definitely be using this app for all of my future shopping needs.",
      likes: 20,
      dislikes: 0,
      date: "January 5, 2022",
    ),
    Review(
      name: "Emily Jones",
      profilePic: "https://picsum.photos/536/354",
      rating: 2,
      review:
          "I was disappointed with my experience using this app. The product I received was not as described and the customer service was unhelpful in resolving the issue.",
      likes: 3,
      dislikes: 9,
      date: "December 15, 2021",
    ),
    Review(
      name: "David Lee",
      profilePic: "https://picsum.photos/536/354",
      rating: 4,
      review:
          "I found what I was looking for quickly and easily on this app. The checkout process was straightforward and the product arrived on time.",
      likes: 8,
      dislikes: 1,
      date: "November 22, 2021",
    ),
  ];
  String averageRating = '0';
  late int totalReviews = reviews.length;
  @override
  Widget build(BuildContext context) {
    averageRating = findAverage().toString();
    print(averageRating);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reviews"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.btncolor,
          onPressed: () {
            BottomModalSheet(context).showModal(
                child: Container(
              height: 400,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const HeadingText(text: 'Rating'),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const HeadingText(text: 'Review'),
                  TextFormField(
                    maxLines: 6,
                    decoration: const InputDecoration(
                        hintText: "What's in your mind", label: Text("Review")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.btncolor,
                      fixedSize: Size(CustomMediaQuery(context).width * .8, 40),
                    ),
                    onPressed: () {},
                    child: Text('click'),
                  ),
                ],
              ),
            ));
          },
          child: const Icon(Icons.edit),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: HeadingText(text: 'Rating'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        HeadingText(
                          text: averageRating,
                        ),
                        SubHeadingText(text: '${reviews.length} Reviews')
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildRatingStars(5),
                        _buildRatingStars(4),
                        _buildRatingStars(3),
                        _buildRatingStars(2),
                        _buildRatingStars(1),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildRatingStaticBar(),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: HeadingText(text: 'Rating & Review'),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return _buildReviewItem(reviews[index]);
                    }),
              )
            ],
          ),
        ));
  }

// generating star
  Widget _buildRatingStars(int rating) {
    List<Widget> stars = [];
    for (var i = 0; i < rating; i++) {
      stars.add(
        Icon(Icons.star, color: Colors.amber, size: 20),
      );
    }
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: stars);
  }

  // generating static for rating

  Widget _buildRatingStaticBar() {
    final ratingDistribution = _calculateRatingDistribution();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 130,
            child: LinearProgressIndicator(
              minHeight: 7,
              value: ratingDistribution[5]! / totalReviews,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(MyColors.btncolor),
            ),
          ),
          Text(
            ratingDistribution[5].toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ]),
        const SizedBox(width: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 130,
            child: LinearProgressIndicator(
              minHeight: 7,
              value: ratingDistribution[4]! / totalReviews,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(MyColors.btncolor),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          Text(
            ratingDistribution[4].toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ]),
        const SizedBox(width: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 130,
            child: LinearProgressIndicator(
              minHeight: 7,
              value: ratingDistribution[3]! / totalReviews,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(MyColors.btncolor),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          Text(
            ratingDistribution[3].toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ]),
        const SizedBox(width: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 130,
            child: LinearProgressIndicator(
              minHeight: 7,
              value: ratingDistribution[2]! / totalReviews,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(MyColors.btncolor),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          Text(
            ratingDistribution[2].toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ]),
        const SizedBox(width: 5),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 130,
            child: LinearProgressIndicator(
              minHeight: 7,
              value: ratingDistribution[1]! / totalReviews,
              backgroundColor: Colors.grey[300],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(MyColors.btncolor),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          Text(
            ratingDistribution[1].toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ]),
      ],
    );
  }

  double findAverage() {
    double avg = 0;
    for (var review in reviews) {
      avg += review.rating;
    }

    return avg / totalReviews;
  }

  Map<int, int> _calculateRatingDistribution() {
    final ratingDistribution = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
    };
    for (var review in reviews) {
      ratingDistribution[review.rating] =
          ratingDistribution[review.rating]! + 1;
    }

    return ratingDistribution;
  }

  // item list

  Widget _buildReviewItem(Review review) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(review.profilePic),
                radius: 20,
              ),
              const SizedBox(width: 10),
              SubHeadingText(
                text: review.name,
              ),
              const SizedBox(width: 10),
              _buildRatingStars(review.rating),
            ],
          ),
          const SizedBox(height: 10),
          ExpandableText(text: review.review),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_up_alt),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    review.likes.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_down_alt),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    review.dislikes.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Text(
                review.date,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Review {
  final String name;
  final String profilePic;
  final int rating;
  final String review;
  final int likes;
  final int dislikes;
  final String date;

  Review({
    required this.name,
    required this.profilePic,
    required this.rating,
    required this.review,
    required this.likes,
    required this.dislikes,
    required this.date,
  });
}
