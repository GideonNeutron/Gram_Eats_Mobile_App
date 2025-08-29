import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gram_eats/view/mainScreens/home_screen.dart';
import '../../../model/item.dart';
import '../../global/global_instances.dart';
import '../../model/menu.dart';
import '../widgets/item_ui_design.dart';
import '../widgets/my_appbar.dart';


class ItemsScreen extends StatefulWidget
{
  final Menu? menuModel;
  String? value;

  ItemsScreen({super.key, this.menuModel, this.value});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer:MyDrawer(),
      appBar: AppBar(
        title: Text(
          widget.menuModel!.menuTitle.toString() + "'s Items",
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: ()
          {
            if(widget.value == "rp")
            {
              Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
            }
            else
            {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: itemViewModel.retrieveItemsFromFirestore(widget.menuModel!.sellerUID!, widget.menuModel!.menuID!),
        builder: (context, snapshot)
        {
          return !snapshot.hasData
              ? const Center(child: Text("No Data Available"),)
              : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index)
            {
              //return Container();
              Item itemModel = Item.fromJson(
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>
              );

              return Card(
                elevation: 6,
                color: Colors.black87,
                child: ItemUIDesign(
                  itemModel: itemModel,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
