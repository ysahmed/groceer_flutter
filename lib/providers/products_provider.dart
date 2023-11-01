import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_shop/models/cart_item_model.dart';
import 'package:grocery_shop/models/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  ProductsProvider() {
    _getProducts();
  }

  // fetch products
  Future<void> _getProducts() async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        String jsonList =
            await rootBundle.loadString('assets/data/products.json');
        List data = jsonDecode(jsonList);
        _products = data.map((element) => Product.fromJson(element)).toList();
        notifyListeners();
      },
    );
  }

  // add to cart
  void addToCart(Product product) {
    if (!product.existsIn(_cartItems)) {
      _cartItems.add(CartItem(product: product));
    } else {
      int index = product.findIn(_cartItems);

      _cartItems[index].incrementCount();
    }
    notifyListeners();
    // print(_cartItems);
  }

  // add to cart
  void addToCartx(int index) {
    if (!products[index].existsIn(_cartItems)) {
      _cartItems.add(CartItem(product: products[index]));
    } else {
      int i = products[index].findIn(_cartItems);

      _cartItems[i].incrementCount();
    }
    notifyListeners();
    // print(_cartItems);
  }

  // remove from cart
  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void itemIncrement(int index) {
    _cartItems[index].incrementCount();
    notifyListeners();
  }

  void itemDecrement(int index) {
    _cartItems[index].decrementCount();
    notifyListeners();
  }

  // calculate total price
  String getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.product.price * item.count;
    }

    return total.toStringAsFixed(2);
  }
}
