import 'package:e_commerce_app/firebase/authentication.dart';
import 'package:e_commerce_app/firebase/controller/product_controller.dart';
import 'package:e_commerce_app/firebase/controller/user_controller.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/model/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _user;
  final AuthenticationClass _authController = AuthenticationClass();
  final UserController _userController = UserController();
  UserModel get user => _user;

  Future<void> fetchUserDataPf() async {
    await _authController
        .userData()
        .then((value) => {_user = UserModel.fromJson(value!)});
    notifyListeners();
  }

  Future<void> updateAddressPf({required int oldId, required int newId}) async {
    for (var e in _user.address) {
      if (e['id'] == oldId) {
        e['default'] = false;
      }
      if (e['id'] == newId) {
        e['default'] = true;
      }
    }

    await _userController.updateAddress(address: _user.address);
    notifyListeners();
  }

  Future<void> deleteAddressPf({required int uid}) async {
    _user.address.removeWhere((obj) => obj.id == uid);
    await _userController.deleteAddress(address: _user.address);
    notifyListeners();
  }

  Future<void> addAddressPf({required Map<String, dynamic> address}) async {
    await _userController.addAddress(address: address);
    _user.address.add(address);
    notifyListeners();
  }
}
