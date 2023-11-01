import 'package:grocery_shop/models/cart_item_model.dart';
import 'package:grocery_shop/models/item_interface.dart';

class Product implements Item {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  final String description;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imagePath,
      required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'].toDouble(),
        imagePath: json['image'],
        description: json['description']);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Product &&
            name == other.name &&
            id == other.id &&
            price == other.price;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;

  bool existsIn(List<CartItem> cartItems) {
    for (CartItem item in cartItems) {
      if (item.product == this) return true;
    }
    return false;
  }

  int findIn(List<CartItem> cartItems) {
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].product == this) return i;
    }
    return -1;
  }
}
