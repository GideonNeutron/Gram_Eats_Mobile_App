import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/provider/address_changer.dart';
import 'package:gram_eats/view/mainScreens/save_address_screen.dart';
import 'package:gram_eats/view/widgets/address_ui_design.dart';
import 'package:provider/provider.dart';

import '../../model/address.dart';

class AddressScreen extends StatefulWidget
{
  double? totalAmount;
  String? sellerUID;

  AddressScreen({super.key, this.totalAmount, this.sellerUID});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Address"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add New Address"),
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add_location),
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (c) => SaveAddressScreen()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,

        children: [


          Consumer<AddressChanger>(builder: (context, address, c)
            {
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: addressViewModel.retrieveUserShipmentAddress(),
                  builder: (context, snapshot)
                  {
                    return !snapshot.hasData
                        ? const Center(child: Text("No Address"),)
                        : snapshot.data!.docs.length == 0
                        ? const Center(child: Text("Please add new address first"),)
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index)
                            {
                              return AddressUIDesign(
                                currentIndex: address.count,
                                value: index,
                                addressID: snapshot.data!.docs[index].id,
                                totalAmount: widget.totalAmount,
                                sellerUID: widget.sellerUID,
                                model: Address.fromJson(
                                  snapshot.data!.docs[index].data()! as Map<String, dynamic>
                                ),
                              );
                            },
                        );
                  },
                ),
              );
            },),
        ],
      ),
    );
  }
}
