import 'package:flutter/material.dart';
import 'package:grocery_shop/utils/constants.dart';

class GroceryItemTile extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final VoidCallback onPressedButton;
  final VoidCallback onTapItem;

  const GroceryItemTile({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.onPressedButton,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTapItem,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.blue[50],
          ),
          child: Padding(
            padding: const EdgeInsets.all(paddingSmall),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                Image.asset(
                  image,
                  height: 45,
                ),
                const Spacer(),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MaterialButton(
                  shape: const ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(cornerRadius)),
                  ),
                  onPressed: onPressedButton,
                  color: Colors.white,
                  child: Text('\$ $price'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
