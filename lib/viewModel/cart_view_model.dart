import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/global/global_vars.dart';
import 'package:gram_eats/provider/cart_item_counter.dart';
import 'package:provider/provider.dart';

class CartViewModel
{
  separateItemIDs()
  {
    List<String> separateItemIDsList = [], defaultItemList = [];
    int i=0;

    defaultItemList = sharedPreferences!.getStringList("userCart")!;

    for(i; i<defaultItemList.length; i++)
    {
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      String getItemId = (pos != -1) ? item.substring(0, pos) : item;

      print("\nThis is an itemID now = "+ getItemId);

      separateItemIDsList.add(getItemId);
    }

    print("\nThis is the Items List Now = ");
    print(separateItemIDsList);
    return separateItemIDsList;
  }

  addItemToCart(String? itemId, BuildContext context, int quantityNumber)
  {
    List<String>? tempList = sharedPreferences!.getStringList("userCart");
    tempList!.add(itemId! + ":" + quantityNumber.toString());

    FirebaseFirestore.instance.collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update(
      {
        "userCart": tempList,
      }).then((value)
      {
        sharedPreferences!.setStringList("userCart", tempList);

        commonViewModel.showSnackBar("Item added to Cart", context);

        //update the cart badge using provider(state management)
        Provider.of<CartItemCounter>(context, listen: false).showCartListItemsNumber();
      });
  }

  getCartItems()
  {
    return FirebaseFirestore.instance
      .collection("items")
      .where("itemID", whereIn: separateItemIDs())
      .orderBy("publishedDateTime", descending: true)
      .snapshots();
  }

  separateItemQuantities()
  {
    List<int> separateItemQuantityList = [];
    List<String> defaultItemList = [];
    int i = 1;

    defaultItemList = sharedPreferences!.getStringList("userCart")!;

    for(i; i<defaultItemList.length; i++)
      {
        String item = defaultItemList[i].toString();

        List<String> listItemCharacters = item.split(":").toList();

        var quanNumber = int.parse(listItemCharacters[1].toString());

        separateItemQuantityList.add(quanNumber);
      }
    return separateItemQuantityList;
  }

  clearCartNow(BuildContext context) async
  {
    sharedPreferences!.setStringList("userCart", ['garbageValue']);
    List<String>? emptyList = sharedPreferences!.getStringList("userCart");

    await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update(
        {
          "userCart": emptyList,
        }).then((value)
          {
            sharedPreferences!.setStringList("userCart", emptyList!);
            Provider.of<CartItemCounter>(context, listen: false).showCartListItemsNumber();
          });
  }
}