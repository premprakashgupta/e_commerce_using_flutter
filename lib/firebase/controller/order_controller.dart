import 'package:e_commerce_app/model/product_model.dart';
import 'package:random_string/random_string.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/firebase/firebase_instance.dart';
import 'package:e_commerce_app/model/order_modal.dart';

class OrderController {
  Future<List<OrderModel>> fetchOrders() async {
    List<OrderModel> temp = [];

    await FirebaseInstance.db
        .collection('users')
        .doc(FirebaseInstance.auth.currentUser!.uid)
        .collection('orders')
        .get()
        .then((value) => {
              for (var element in value.docs)
                {
                  temp.add(
                    OrderModel.fromJson(element.data()),
                  ),
                }
            });

    return temp;
  }

  Future<void> addOrder({required Map<String, dynamic> data}) async {
    // adding data in orders collection ------------
    await FirebaseInstance.db
        .collection('users')
        .doc(FirebaseInstance.auth.currentUser!.uid)
        .collection('orders')
        .add(data);
    // deleting all data from cart collection --------------
    await FirebaseInstance.db
        .collection('users')
        .doc(FirebaseInstance.auth.currentUser!.uid)
        .collection('cart')
        .get()
        .then((value) => {
              for (var element in value.docs) {element.reference.delete()}
            });
  }
}
