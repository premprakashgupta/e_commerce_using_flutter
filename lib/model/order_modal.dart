import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/model/product_model.dart';

class OrderModel {
  final int amount;
  final DateTime orderDate;
  final int orderNumber;
  final String orderStatus;
  final bool paymentStatus;
  final int quantity;
  final String trackingNumber;
  final List<CartModel> cart;
  final dynamic address;

  OrderModel({
    required this.address,
    required this.amount,
    required this.orderDate,
    required this.orderNumber,
    required this.orderStatus,
    required this.paymentStatus,
    required this.quantity,
    required this.trackingNumber,
    required this.cart,
  });
  // converting map to object
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      address: json['address'],
      amount: json['amount'],
      orderDate: (json['order_date'] as Timestamp).toDate(),
      orderNumber: json['order_number'],
      orderStatus: json['order_status'],
      paymentStatus: json['payment_status'],
      quantity: json['quantity'],
      trackingNumber: json['tracking_number'],
      cart: (json['cart'] as List<dynamic>)
          .map((e) => CartModel.fromJson(e))
          .toList(),
    );
  }
  // converting object to map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['address'] = address;
    data['amount'] = amount;
    data['order_date'] = orderDate;
    data['order_number'] = orderNumber;
    data['order_status'] = orderStatus;
    data['payment_status'] = paymentStatus;
    data['quantity'] = quantity;
    data['tracking_number'] = trackingNumber;
    data['cart'] = cart.map((x) => x.toJson()).toList();
    return data;
  }
}
