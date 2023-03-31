import 'package:e_commerce_app/apihandler/api_handler.dart';
import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/firebase/controller/product_controller.dart';

import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/screens/bag_screen.dart';
import 'package:e_commerce_app/utils/alert.dart';
import 'package:e_commerce_app/utils/media_query.dart';

import 'package:e_commerce_app/widget/expandable_text.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/my_horizontal_list.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // Default values for dropdown menus
  String _selectedSize = 'M';
  String _selectedColor = 'Red';
  late Map<String, dynamic> singleproductData;
  late Future<List<CatelogModel>> relatedproductData;

  @override
  void initState() {
    // TODO: implement initState

    _load();
    super.initState();
  }

  Future<void> _load() async {
    try {
      SingleProductModal res =
          await ApiHandler().fetchSingleProduct(productId: widget.productId);
      singleproductData = res.toJson();
      setState(() {});
    } catch (e) {
      CustomAlert(context: context).error(error: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomAppBar(
            height: 70,
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.btncolor,
                      fixedSize: Size(CustomMediaQuery(context).width * .8, 40),
                    ),
                    onPressed: () async {
                      try {
                        await cartProvider.addToCartPf(
                            cartItem: singleproductData);
                      } catch (e) {
                        CustomAlert(context: context)
                            .error(error: e.toString());
                      }
                    },
                    child: const Text('ADD TO CART'),
                  ),
                );
              },
            )),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future:
                  ApiHandler().fetchSingleProduct(productId: widget.productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product picture
                      Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.6, // 70% of screen height
                              child: Image.network(
                                snapshot.data!.images[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          ),
                          Positioned(
                            top: 13,
                            right: 13,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BagScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_cart_outlined)),
                          ),
                          Positioned(
                            right: 11,
                            top: 11,
                            child: Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                                return Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 14,
                                    minHeight: 14,
                                  ),
                                  child: Text(
                                    '${cartProvider.cartItems.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Dropdown menus and wishlist button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Size dropdown menu
                            SizedBox(
                              width: CustomMediaQuery(context).width * .33,
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                ),
                                value: _selectedSize,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSize = value!;
                                  });
                                },
                                items: ['S', 'M', 'L', 'XL']
                                    .map((size) => DropdownMenuItem(
                                          value: size,
                                          child: Text(size),
                                        ))
                                    .toList(),
                              ),
                            ),
                            // Color dropdown menu
                            SizedBox(
                              width: CustomMediaQuery(context).width * .33,
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                ),
                                value: _selectedColor,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedColor = value!;
                                  });
                                },
                                items: ['Red', 'Green', 'Blue', 'Yellow']
                                    .map((color) => DropdownMenuItem(
                                          value: color,
                                          child: Text(color),
                                        ))
                                    .toList(),
                              ),
                            ),
                            // Wishlist button
                            IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {
                                // Add to wishlist
                              },
                            ),
                          ],
                        ),
                      ),
                      // Product title and price
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeadingText(
                              text: snapshot.data!.title,
                            ),
                            HeadingText(
                              text: '₹ ${snapshot.data!.price.toString()}',
                            ),
                          ],
                        ),
                      ),
                      // Product category
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Row(
                          children: [
                            const SubHeadingText(
                              text: 'Category',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // rating
                            RatingBar.builder(
                              itemSize: 20,
                              ignoreGestures: true,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Product description
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ExpandableText(
                          text: snapshot.data!.description,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right),
                          title: ParaText(
                            text: 'Shopping Info',
                            size: 16,
                            color: Colors.black45,
                          ),
                          shape: Border.symmetric(
                            horizontal:
                                BorderSide(width: 1, color: Colors.black45),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right),
                          title: ParaText(
                            text: 'Support',
                            size: 16,
                            color: Colors.black45,
                          ),
                          shape: BorderDirectional(
                            bottom: BorderSide(width: 1, color: Colors.black45),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: HeadingText(text: 'Related product you like'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: MyHorizontalList(),
                      ),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  );
                }
              }),
        ));
  }
}
