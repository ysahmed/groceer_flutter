import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/models/product_model.dart';
import 'package:grocery_shop/pages/cart_page.dart';
import 'package:grocery_shop/providers/products_provider.dart';
import 'package:grocery_shop/utils/constants.dart';
import 'package:grocery_shop/widgets/dialog_box.dart';
import 'package:grocery_shop/widgets/grocery_item_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Consumer<ProductsProvider>(
          builder: (context, value, child) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ));
              },
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              elevation: 0,
              child: _faIcon(value.cartItems.length),
            );
          },
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top portion
              _topPortion(),
              _itemGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topPortion() => Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good morning!",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            Text(
              "Let's order some goodness for you.",
              style: GoogleFonts.notoSerif(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: paddingMedium),
              child: Text(
                "Fresh items",
              ),
            ),
          ],
        ),
      );

  Widget _itemGrid() => Expanded(
        child: Consumer<ProductsProvider>(
          builder: (context, value, child) {
            if (value.products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return GridView.builder(
              itemCount: value.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                Product product = value.products[index];
                return GroceryItemTile(
                    onPressedButton: () =>
                        Provider.of<ProductsProvider>(context, listen: false)
                            .addToCart(product),
                    onTapItem: () => _showDetailDialog(context, index),
                    // onTapItem: () => _showItemDetail(
                    //     context: context,
                    //     product: product,
                    //     fnAddToCart: Provider.of<ProductsProvider>(context,
                    //             listen: false)
                    //         .addToCart),
                    image: product.imagePath,
                    name: product.name,
                    price: product.price);
              },
            );
          },
        ),
      );

  Widget _faIcon(int itemCount) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const Icon(
          Icons.shopping_bag_outlined,
          size: 36,
          color: Colors.black,
        ),
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: Text(
            itemCount.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _showDetailDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => DialogBox<Product>(index: index),
    );
  }
}
