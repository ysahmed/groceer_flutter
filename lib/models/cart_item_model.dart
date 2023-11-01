import 'package:grocery_shop/models/item_interface.dart';
import 'package:grocery_shop/models/product_model.dart';

class CartItem implements Item {
  late final Product _product;
  Product get product => _product;

  late int _count;
  int get count => _count;

  CartItem({required Product product, int count = 1})
      : _count = count,
        _product = product;

  @override
  String toString() => "${_product.name} $_count";

  void incrementCount() {
    _count++;
  }

  void decrementCount() {
    if (_count > 1) _count--;
  }

  bool existsIn(List<CartItem> cartItems) {
    for (CartItem item in cartItems) {
      if (this == item) {
        return true;
      }
    }
    return false;
  }

  int existsAt(List<CartItem> cartItems) {
    for (int i = 0; i < cartItems.length; i++) {
      if (this == cartItems[i]) {
        return i;
      }
    }
    return -1;
  }
}
