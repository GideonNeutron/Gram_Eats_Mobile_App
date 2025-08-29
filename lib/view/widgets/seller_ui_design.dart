import 'package:flutter/material.dart';
import 'package:gram_eats/model/seller.dart';

import '../../model/item.dart';
import '../mainScreens/menu_screen.dart';

class SellerUIDesign extends StatefulWidget
{
  Seller? sellerModel;
  SellerUIDesign({super.key, this.sellerModel,});

  @override
  State<SellerUIDesign> createState() => _SellerUIDesignState();
}

class _SellerUIDesignState extends State<SellerUIDesign> {
  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => MenuScreen(sellerModel: widget.sellerModel,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          //height: 255,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [

              Image.network(
                widget.sellerModel!.image.toString(),
                width: MediaQuery.of(context).size.width,
                height: 210,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 1,),

              Text(
                widget.sellerModel!.name.toString(),
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: "Train",
                ),
              ),

              Text(
                widget.sellerModel!.email.toString(),
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 3,),
            ],
          ),
        ),
      ),
    );
  }
}
