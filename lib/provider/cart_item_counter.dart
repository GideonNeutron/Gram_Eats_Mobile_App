import 'package:flutter/cupertino.dart';
import 'package:gram_eats/global/global_vars.dart';

class CartItemCounter extends ChangeNotifier
{
  int cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length - 1;
  int get count => cartListItemCounter;

  showCartListItemsNumber()async
  {
    cartListItemCounter = sharedPreferences!.getStringList("userCart")!.length - 1;
    notifyListeners();
  }
}