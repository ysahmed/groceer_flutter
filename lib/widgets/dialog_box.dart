import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/models/cart_item_model.dart';
import 'package:grocery_shop/models/item_interface.dart';
import 'package:grocery_shop/models/product_model.dart';
import 'package:grocery_shop/providers/products_provider.dart';
import 'package:grocery_shop/utils/constants.dart';
import 'package:provider/provider.dart';

class DialogBox<T extends Item> extends StatelessWidget {
  final int index;
  const DialogBox({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    String name = "";
    String imagePath = "";
    String price = "";
    String description = "";
    String buttonText = "";
    IconData buttonIcon = const IconData(0);

    return AlertDialog(
      backgroundColor: Colors.green[100],
      content: SizedBox(
        height: 275,
        child: Consumer<ProductsProvider>(
          builder: (context, value, child) {
            if (T == Product) {
              var product = value.products[index];
              name = product.name;
              imagePath = product.imagePath;
              price = "\$${product.price}";
              description = product.description;
              buttonText = "Add to cart";
              buttonIcon = Icons.shopping_bag_outlined;
            }
            if (T == CartItem) {
              var item = value.cartItems[index];
              name = item.product.name;
              imagePath = item.product.imagePath;
              price =
                  "\$${(item.product.price * item.count).toStringAsFixed(2)}";
              buttonText = "Done";
              buttonIcon = Icons.check_outlined;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // product name
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),

                // image
                Image.asset(
                  imagePath,
                  height: 100,
                ),
                const Spacer(),

                // price
                Text(
                  price,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),

                // product description
                if (T == Product)
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(
                      fontSize: 16,
                    ),
                  ),

                // number increment decrement
                () {
                  if (T == CartItem) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // decrement button
                        IconButton(
                          onPressed: () => value.itemDecrement(index),
                          icon: const Icon(Icons.remove_circle),
                        ),
                        Text(
                          value.cartItems[index].count.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // increment button
                        IconButton(
                          onPressed: () => value.itemIncrement(index),
                          icon: const Icon(Icons.add_circle),
                        ),
                      ],
                    );
                  }
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }(),

                if (T == CartItem)
                  // remove button
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Future.delayed(
                        const Duration(milliseconds: 200),
                        () => value.removeFromCart(index),
                      );
                    },
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(cornerRadius)),
                    // color: Colors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Color.fromARGB(255, 167, 13, 2),
                        ),
                        Text(
                          "Remove from cart",
                          style: TextStyle(
                            color: Color.fromARGB(255, 167, 13, 2),
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 167, 13, 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (T == Product)
                  // Done button
                  MaterialButton(
                    onPressed: () {
                      if (T == Product) {
                        value.addToCartx(index);
                      }
                      if (T == CartItem) {
                        Navigator.pop(context);
                      }
                    },
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(cornerRadius)),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(buttonIcon),
                        Text(buttonText),
                      ],
                    ),
                  )
              ],
            );
          },
        ),
      ),
      // actions: () {
      //   if (T == CartItem)
      //     return [
      //       TextButton(onPressed: () {}, child: Text('Remove')),
      //     ];
      // }(),
      // actionsAlignment: MainAxisAlignment.center,
      // actionsPadding: EdgeInsets.symmetric(vertical: 8),
      // actionsOverflowDirection: VerticalDirection.down,
    );
  }

  Widget _description(String description) {
    if (T == Product) {
      return Text(
        description,
        style: GoogleFonts.notoSerif(
          fontSize: 16,
        ),
      );
    }
    if (T == CartItem) {}
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }
}
