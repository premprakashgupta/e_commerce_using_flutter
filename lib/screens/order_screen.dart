import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/model/order_modal.dart';
import 'package:e_commerce_app/providers/order_provider.dart';
import 'package:e_commerce_app/screens/order_detail.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const HeadingText(text: 'Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (BuildContext context, orderProvider, Widget? child) {
          return ListView.builder(
            itemCount: orderProvider.orders.length,
            itemBuilder: (BuildContext context, int index) {
              OrderModel data = orderProvider.orders[index];
              print(data);
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order ${data.orderNumber}',
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text('${data.orderDate}',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey[600])),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text('Tracking Number: ${data.trackingNumber}',
                          style: const TextStyle(fontSize: 16.0)),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Quantity: ${data.quantity}',
                              style: const TextStyle(fontSize: 16.0)),
                          Text('Total Amount: ₹ ${data.amount}',
                              style: const TextStyle(fontSize: 16.0)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                    item: data,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Details'),
                          ),
                          const SizedBox(height: 8.0),
                          Text(data.orderStatus,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
