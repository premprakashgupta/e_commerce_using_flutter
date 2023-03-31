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
}
