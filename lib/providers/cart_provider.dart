import 'package:e_commerce_app/firebase/controller/product_controller.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> _cartItems = [];
  ProductController _productController = ProductController();

  List<CartModel> get cartItems => _cartItems;
  set cartItems(List<CartModel> value) {
    _cartItems = value;
    notifyListeners();
  }

  Future<void> fetchCartItemsPf() async {
    _cartItems = await _productController.cartItems();
    notifyListeners();
  }

  Future<void> addToCartPf({required Map<String, dynamic> cartItem}) async {
    String? response = await _productController.addToCart(data: cartItem);
    if (response == 'success') {
      _cartItems.add(
        CartModel.fromJson({'uid': "dhgshkdk", 'item_count': 1, ...cartItem}),
      );
      notifyListeners();
    } else {
      // handle error
    }
  }

  Future<String?> deleteCartItemPf(CartModel cartItem) async {
    String? response = await _productController.deleteCartItem(
        itemId: cartItem.id, catId: cartItem.category.id);
    if (response == 'success') {
      _cartItems.remove(cartItem);

      notifyListeners();

      // return response;
    } else {
      // handle error
    }
    return null;
  }

  Future<String?> itemCount(
      {required CartModel cartItem, required String option}) async {
    if (cartItem.item_count == 1 && option == 'minus')
      return 'you cant decrease';
    if (cartItem.item_count == 5 && option == 'plus')
      return 'you cant increase';
    String? response = await _productController.itemCount(
        itemId: cartItem.id, catId: cartItem.category.id, option: option);
    if (response == 'success') {
      if (option == 'plus') {
        for (var element in _cartItems) {
          if (element.id == cartItem.id &&
              element.category.id == cartItem.category.id) {
            element.item_count += 1;
          }
        }
      } else {
        for (var element in _cartItems) {
          if (element.id == cartItem.id &&
              element.category.id == cartItem.category.id) {
            element.item_count -= 1;
          }
        }
      }

      notifyListeners();

      // return response;
    } else {
      // handle error
    }
    return null;
  }
}
