import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/models/cart_item_model.dart';
import 'package:grocery_shop/providers/products_provider.dart';
import 'package:grocery_shop/widgets/dialog_box.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/utils/constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: const Text("Your Cart"),
          centerTitle: false,
        ),
        body: Consumer<ProductsProvider>(
          builder: (context, value, child) {
            if (value.cartItems.isEmpty) {
              // empty cart ui
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/empty_cart.png",
                        height: 200,
                      ),
                      Text(
                        "Empty cart!\nAdd some goodness.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSerif(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // the ListView + total + payNow
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Items: ", style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.cartItems.length,
                      itemBuilder: (context, index) {
                        var item = value.cartItems[index];

                        // cart item
                        return GestureDetector(
                          onTap: () => _showEditDialog(context, index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: paddingSmall),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius:
                                    BorderRadius.circular(cornerRadius),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  item.product.imagePath,
                                  height: 30,
                                ),
                                title: Text(item.count > 1
                                    ? "${item.product.name} x${item.count}"
                                    : item.product.name),
                                subtitle: Text(
                                    "\$${(item.product.price * item.count).toStringAsFixed(2)}"),
                                trailing: IconButton(
                                    onPressed: () =>
                                        value.removeFromCart(index),
                                    icon: const Icon(Icons.cancel_outlined)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // total + pay now
                  Padding(
                    padding: const EdgeInsets.only(
                        top: paddingSmall, bottom: paddingLarge),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[300],
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Total amount',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '\$${value.getTotalPrice()}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Pay now",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox<CartItem>(index: index);
      },
    );
  }
}
