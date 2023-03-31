import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/SuccessScreen.dart';
import 'package:e_commerce_app/screens/shipping_address_screen.dart';
import 'package:e_commerce_app/utils/alert.dart';
import 'package:e_commerce_app/utils/media_query.dart';
import 'package:e_commerce_app/widget/container.dart';

import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final int totalAmount;
  final List<CartModel> cart;
  const CheckoutScreen(
      {super.key, required this.totalAmount, required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isLoading = false;

  void _proceed() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 5)); // Wait for 5 seconds

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessScreen()),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CheckoutScreen'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: Provider.of<UserProvider>(context, listen: false)
                .fetchUserDataPf(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: SubHeadingText(
                    text: snapshot.error.toString(),
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Consumer<UserProvider>(
                          builder: (BuildContext context, userProvider,
                              Widget? child) {
                            dynamic address = userProvider.user.address.isEmpty
                                ? null
                                : userProvider.user.address.firstWhere(
                                    (item) => item['default'] == true,
                                    orElse: () => null);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  color: Colors.grey[100],
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: const Text(
                                    'Shopping Address:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                address == null
                                    ? ShadowContainer(
                                        child: Column(
                                          children: [
                                            SubHeadingText(
                                                text:
                                                    'Please change address..'),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShippingAddressScreen(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Change',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ShadowContainer(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SubHeadingText(
                                                    text: address['name']),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ShippingAddressScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Change',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ParaText(
                                                text: '${address['address']}'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ParaText(
                                                text: '${address['pin_code']}')
                                          ],
                                        ),
                                      ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Payment:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Change',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      Row(
                                        children: [
                                          Image.network(
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
                                            height: 24.0,
                                          ),
                                          const SizedBox(width: 16.0),
                                          const Text(
                                            '**** **** **** 1234',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: const Text(
                                    'Delivery Method:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://upload.wikimedia.org/wikipedia/en/b/b6/E-kart-logo.png'),
                                            fit: BoxFit.contain,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://qph.cf2.quoracdn.net/main-qimg-bff1b59dfae5a1b513c69616c97d0f80'),
                                            fit: BoxFit.cover,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SubHeadingText(text: 'Order'),
                                    SubHeadingText(
                                      text: '₹ ${widget.totalAmount}',
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    SubHeadingText(text: 'Delivery'),
                                    SubHeadingText(
                                      text: '₹ 40',
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const HeadingText(text: 'Total'),
                                    HeadingText(
                                      text: '₹ ${widget.totalAmount + 40}',
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Consumer<OrderProvider>(
                                  builder: (BuildContext context, orderProvider,
                                      Widget? child) {
                                    return Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: MyColors.btncolor,
                                          fixedSize: Size(
                                              CustomMediaQuery(context).width *
                                                  .8,
                                              40),
                                        ),
                                        onPressed: address == null
                                            ? null
                                            : () async {
                                                _proceed();
                                                try {
                                                  await orderProvider
                                                      .addOrdersPf(
                                                          cart: widget.cart,
                                                          amount: widget
                                                              .totalAmount,
                                                          context: context,
                                                          address: address);
                                                } catch (e) {
                                                  CustomAlert(context: context)
                                                      .error(
                                                    error: e.toString(),
                                                  );
                                                }
                                              },
                                        child: const Text('CHECKOUT'),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        )),
                    isLoading
                        ? Container(
                            width: CustomMediaQuery(context).width,
                            height: CustomMediaQuery(context).height,
                            color: Colors.black.withOpacity(0.5),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        : const SizedBox(),
                  ],
                );
              }
            },
          ),
        ));
  }
}
