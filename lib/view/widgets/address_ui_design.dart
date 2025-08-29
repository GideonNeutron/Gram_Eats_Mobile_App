import 'package:flutter/material.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/provider/address_changer.dart';
import 'package:gram_eats/view/mainScreens/place_order_screen.dart';
import 'package:provider/provider.dart';

import '../../model/address.dart';

class AddressUIDesign extends StatefulWidget
{
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  AddressUIDesign({
    super.key,
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  @override
  State<AddressUIDesign> createState() => _AddressUIDesignState();
}

class _AddressUIDesignState extends State<AddressUIDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        //color: Colors.white70,
        elevation: 6,
        child: Column(
          children: [

            //address info
            Row(
              children: [

                Radio(
                  value: widget.value!,
                  groupValue: widget.currentIndex!,
                  activeColor: Colors.amber,
                  onChanged: (val)
                  {
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                  },
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [

                          TableRow(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                widget.model!.name.toString(),
                                // style: const TextStyle(
                                //   color: Colors.black38,
                                // ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Text(
                                "Phone Number: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                widget.model!.phoneNumber.toString(),
                                // style: const TextStyle(
                                //   color: Colors.black38,
                                // ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Text(
                                "Flat Number: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                widget.model!.flatNumber.toString(),
                                // style: const TextStyle(
                                //   color: Colors.black38,
                                // ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Text(
                                "City: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                widget.model!.city.toString(),
                                // style: const TextStyle(
                                //   color: Colors.black38,
                                // ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Text(
                                "State: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                widget.model!.state.toString(),
                                // style: const TextStyle(
                                //   color: Colors.black38,
                                // ),
                              ),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Text(
                                "Full Address: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                widget.model!.fullAddress.toString(),
                                // style: const TextStyle(
                                //   color: Colors.black38,
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white38,
              ),
              onPressed: ()
              {
                addressViewModel.openGoogleMapWithGeographicPosition(widget.model!.lat!, widget.model!.lng!);
              },
              child: const Text("Check on Maps"),
            ),

            widget.value == Provider.of<AddressChanger>(context).count ?
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black38,
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => PlaceOrderScreen(
                    addressID: widget.addressID,
                    totalAmount: widget.totalAmount,
                    sellerUID: widget.sellerUID,
                  )));
                },
                child: const Text("Proceed"),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
