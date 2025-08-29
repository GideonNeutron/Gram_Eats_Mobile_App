import 'package:flutter/material.dart';
import 'package:gram_eats/provider/cart_item_counter.dart';
import 'package:gram_eats/view/mainScreens/cart_screen.dart';
import 'package:gram_eats/view/mainScreens/home_screen.dart';
import 'package:provider/provider.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget
{
  String? sellerUID;
  String? title;
  PreferredSizeWidget? bottom;

  CartAppBar({
    super.key,
    this.sellerUID,
    this.title,
    //this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(
        title.toString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Colors.black,
        ),
      ),
      actions: [

        Stack(
          children: [

            IconButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c) => CartScreen(sellerUID: sellerUID)));
              },
              icon: const Icon(Icons.shopping_cart,),
            ),

            Positioned(
                child: Stack(
                  children: [

                    const Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.green,
                    ),

                    Positioned(
                      top: 3,
                      right: 4,
                      child: Center(
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, c)
                          {
                            return Text(
                              counter.count.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ],

    );
  }

  @override
  Size get preferredSize => bottom == null
      ? Size(57, AppBar().preferredSize.height)
      : Size(57, 80 + AppBar().preferredSize.height);
}
