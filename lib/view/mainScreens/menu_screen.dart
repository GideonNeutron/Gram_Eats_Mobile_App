import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/model/seller.dart';
import 'package:gram_eats/view/mainScreens/home_screen.dart';
import 'package:provider/provider.dart';
import '../../model/menu.dart';
import '../../provider/cart_item_counter.dart';
import '../widgets/menu_ui_design.dart';
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget
{
  Seller? sellerModel;

  MenuScreen({super.key, this.sellerModel,});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: ()
            {
              //clear cart

              Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
            },
            icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "${widget.sellerModel!.name} Menu",
          style: const TextStyle(
            fontSize: 20,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [

          Stack(
            children: [

              IconButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => CartScreen(sellerUID: widget.sellerModel!.uid)));
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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: menuViewModel.retrieveMenusFromFirestore(widget.sellerModel!.uid!),
        builder: (context, snapshot)
        {
          return !snapshot.hasData
              ? const Center(child: Text("No Data Available"),)
              : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index)
            {
              Menu menuModel = Menu.fromJson(
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>
              );

              return Card(
                elevation: 6,
                color: Colors.black87,
                child: MenuUIDesign(
                  menuModel: menuModel,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
