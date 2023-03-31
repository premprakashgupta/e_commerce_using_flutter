import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/firebase/firebase_instance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class AuthenticationClass {
  Future<String?> signup(
      {required String email,
      required String password,
      required String name}) async {
    final UserCredential userCredential = await FirebaseInstance.auth
        .createUserWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    print(user?.uid);

    await FirebaseInstance.db.collection('users').doc(user?.uid).set(
      {
        'email': email,
        'name': name,
        'role': 'Customer',
        'avatar': 'https://cdn-icons-png.flaticon.com/128/149/149071.png',
        'address': [],
        'id': randomBetween(1111, 999999999)
      },
    );
    return 'success';
  }

  Future<String?> signin(
      {required String email, required String password}) async {
    final UserCredential userCredential = await FirebaseInstance.auth
        .signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    print(user?.uid);
    return 'success';
  }

  Future<Map<String, dynamic>?> userData() async {
    DocumentSnapshot<Map<String, dynamic>> res = await FirebaseInstance.db
        .collection('users')
        .doc(FirebaseInstance.auth.currentUser!.uid)
        .get();
    print(res.data());
    return res.data();
  }
}
