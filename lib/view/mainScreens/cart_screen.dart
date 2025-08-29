import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/provider/cart_item_counter.dart';
import 'package:gram_eats/provider/total_amount.dart';
import 'package:gram_eats/view/mainScreens/address_screen.dart';
import 'package:gram_eats/view/widgets/cart_item_design.dart';
import 'package:provider/provider.dart';
import '../../model/item.dart';


import 'home_screen.dart';

class CartScreen extends StatefulWidget
{
  String? sellerUID;

  CartScreen({super.key, this.sellerUID});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
{
  List<int>? separateItemQuantityList;
  num totalAmount = 0;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;

    separateItemQuantityList = cartViewModel.separateItemQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
          {
            //clear cart
            //cartViewModel.clearCartNow(context);
            //implemented setstate because I think its better than changing screens
            setState(() {
              cartViewModel.clearCartNow(context);
            });


            //Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
            //for moving to the previous screen
            //Navigator.pop(context);


          },
          icon: const Icon(Icons.clear_all),
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          const SizedBox(width: 10,),

          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text("Clear Cart", style: TextStyle(fontSize: 16),),
              icon: const Icon(Icons.clear_all),
              onPressed: ()
              {
                //clear the cart
                setState(() {
                  cartViewModel.clearCartNow(context);
                });
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text("Check Out", style: TextStyle(fontSize: 16),),
              icon: const Icon(Icons.navigate_next),
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c) => AddressScreen(
                  totalAmount: totalAmount.toDouble(),
                  sellerUID: widget.sellerUID,
                )));

              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
            {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: cartProvider.count == 0
                    ? Container()
                    : Text(
                        "Total Amount: " + amountProvider.totalAmount.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              );
            }),

          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: cartViewModel.getCartItems(),
              builder: (context, snapshot)
              {
                return !snapshot.hasData
                  ? const Center(child: Text("No items in cart"),)
                  : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index)
                    {
                      Item itemModel = Item.fromJson(
                        snapshot.data!.docs[index].data() as Map<String, dynamic>
                      );

                      if(index == 0)
                      {
                        totalAmount = 0;
                        totalAmount = totalAmount + (itemModel.price! * separateItemQuantityList![index]);
                      }
                      else
                      {
                        totalAmount = totalAmount + (itemModel.price! * separateItemQuantityList![index]);
                      }

                      if(snapshot.data!.docs.length - 1 == index)
                      {
                        WidgetsBinding.instance!.addPostFrameCallback((timeStamp)
                        {
                          Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble());
                        });
                      }

                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Card(
                          elevation: 6,
                          child: CartItemDesign(
                            itemModel: itemModel,
                            quantityNumber: separateItemQuantityList![index],
                          ),
                        ),
                      );
                    },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
