import 'package:e_commerce_app/firebase/firebase_instance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  Future<void> updateAddress({required List<dynamic> address}) async {
    await FirebaseInstance.db
        .collection('users')
        .doc(FirebaseInstance.auth.currentUser!.uid)
        .update({'address': address});
    print(address);
  }

  Future<void> addAddress({required Map<String, dynamic> address}) async {
    await FirebaseInstance.db
        .collection('users')
        .doc(FirebaseInstance.auth.currentUser!.uid)
        .update({
      'address': FieldValue.arrayUnion([address])
    });
    print(address);
  }
}
