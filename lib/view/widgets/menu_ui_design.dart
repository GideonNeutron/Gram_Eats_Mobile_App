import 'package:flutter/material.dart';
import 'package:gram_eats/model/menu.dart';

import '../mainScreens/items_screen.dart';

class MenuUIDesign extends StatefulWidget
{
  Menu? menuModel;
  MenuUIDesign({super.key, this.menuModel,});

  @override
  State<MenuUIDesign> createState() => _MenuUIDesignState();
}

class _MenuUIDesignState extends State<MenuUIDesign> {
  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemsScreen(menuModel: widget.menuModel,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [

              Image.network(
                widget.menuModel!.menuImage.toString(),
                width: MediaQuery.of(context).size.width,
                height: 240,
                fit: BoxFit.cover,
              ),

              Text(
                widget.menuModel!.menuTitle.toString(),
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  fontFamily: "Train",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
