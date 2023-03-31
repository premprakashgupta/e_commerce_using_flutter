import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/firebase/firebase_instance.dart';
import 'package:e_commerce_app/model/product_model.dart';

class ProductController {
  final _auth = FirebaseInstance.auth;
  Future<String?> addToCart({
    required Map<String, dynamic> data,
  }) async {
    await FirebaseInstance.db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('cart')
        .add({'item_count': 1, ...data});
    return 'success';
  }

  Future<List<CartModel>> cartItems() async {
    List<CartModel> temp = [];
    await FirebaseInstance.db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('cart')
        .get()
        .then((value) => {
              for (var element in value.docs)
                {
                  temp.add(
                    CartModel.fromJson(element.data()),
                  ),
                }
            });

    return temp;
  }

  Future<String?> deleteCartItem(
      {required int itemId, required int catId}) async {
    await FirebaseInstance.db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('cart')
        .where('id', isEqualTo: itemId)
        .where('category.id', isEqualTo: catId)
        .get()
        .then((value) => {
              for (var element in value.docs) {element.reference.delete()}
            });

    return 'success';
  }
}
