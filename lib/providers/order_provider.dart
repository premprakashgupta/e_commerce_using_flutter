import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/firebase/controller/order_controller.dart';
import 'package:e_commerce_app/model/order_modal.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class OrderProvider extends ChangeNotifier {
  final OrderController _orderController = OrderController();
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  Future<void> fetchOrdersPf() async {
    try {
      final List<OrderModel> orderDataList =
          await _orderController.fetchOrders();
      _orders = orderDataList;

      notifyListeners();
    } catch (e) {
      // Handle the error
      print(e.toString());
    }
  }

  Future<void> addOrdersPf(
      {required List<CartModel> cart,
      required int amount,
      required dynamic address,
      required BuildContext context}) async {
    try {
      List<dynamic> temp = [];
      for (var e in cart) {
        temp.add(e.toJson());
      }

      var data = {
        'order_date': Timestamp.now(),
        'payment_status': false,
        'order_status': 'Order Confirm',
        'quantity': cart.length,
        'order_number': randomBetween(1111, 9999),
        'tracking_number': randomAlphaNumeric(10),
        'amount': amount,
        'address': address,
        'cart': temp,
      };
      final CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);
      cartProvider.cartItems = [];
      await _orderController.addOrder(data: data);
      _orders.add(OrderModel.fromJson(data));

      notifyListeners();
    } catch (e, stackTrace) {
      print('Caught exception: $e');
      print('Stack trace: $stackTrace');
    }
  }
}
