import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/screens/checkout_screen.dart';
import 'package:e_commerce_app/utils/alert.dart';
import 'package:e_commerce_app/utils/media_query.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  @override
  Widget build(BuildContext context) {
    double size = CustomMediaQuery(context).width;
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: MyColors.background,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
        ],
      ),
      bottomSheet: BottomAppBar(
        height: 100,
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            int totalAmount = 0;
            for (var item in cartProvider.cartItems) {
              totalAmount += item.price;
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SubHeadingText(
                      text: 'Total Amount',
                    ),
                    HeadingText(text: '₹ ${totalAmount}'),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.btncolor,
                    fixedSize: Size(CustomMediaQuery(context).width * .8, 35),
                  ),
                  onPressed: cartProvider.cartItems.length < 1
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                  totalAmount: totalAmount,
                                  cart: cartProvider.cartItems),
                            ),
                          );
                        },
                  child: const Text('CHECKOUT'),
                ),
              ],
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: HeadingText(text: 'My Bag')),
            const SizedBox(
              height: 15,
            ),
            Flexible(child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<CartModel> data = cartProvider.cartItems;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(data[index].images[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size * .4,
                                        child: Text(
                                          data[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: size < 480 ? 16 : 24,
                                              color: Colors.black),
                                        ),
                                      ),
                                      _popUpmenu(cartItem: data[index])
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: size < 480 ? 30 : 40,
                                            height: size < 480 ? 30 : 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                await cartProvider.itemCount(
                                                    cartItem: cartProvider
                                                        .cartItems[index],
                                                    option: 'minus');
                                              },
                                              icon: Icon(
                                                  size: size < 480 ? 16 : 20,
                                                  Icons.remove),
                                            ),
                                          ),
                                          SizedBox(width: size * .015),
                                          Text('${data[index].item_count}'),
                                          SizedBox(width: size * .015),
                                          Container(
                                            width: size < 480 ? 30 : 40,
                                            height: size < 480 ? 30 : 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                await cartProvider.itemCount(
                                                    cartItem: cartProvider
                                                        .cartItems[index],
                                                    option: 'plus');
                                              },
                                              icon: Icon(
                                                  size: size < 480 ? 16 : 20,
                                                  Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                      HeadingText(
                                          text: '₹ ${data[index].price}')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _popUpmenu({required CartModel cartItem}) {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return PopupMenuButton<SampleItem>(
        // Callback that sets the selected popup menu item.
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),

        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemOne,
            child: Text('Add to favorite'),
          ),
          PopupMenuItem<SampleItem>(
            onTap: () async {
              try {
                String? res = await cartProvider.deleteCartItemPf(cartItem);
              } catch (e) {
                CustomAlert(context: context).error(error: e.toString());
              }
            },
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            value: SampleItem.itemTwo,
            child: const Text('Remove from cart'),
          ),
        ],
      );
    });
  }
}
