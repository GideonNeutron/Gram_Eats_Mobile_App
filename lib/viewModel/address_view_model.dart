import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/global/global_vars.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressViewModel
{
  saveShipmentAddressToDatabase(name, state, fullAddress, phoneNumber, flatNumber, city, lat, lng, BuildContext context)
  {
    FirebaseFirestore.instance.collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("userAddress")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(
        {
          "name": name,
          "phoneNumber": phoneNumber,
          "flatNumber": flatNumber,
          "city": city,
          "state": state,
          "fullAddress": fullAddress,
          "lat": lat,
          "lng": lng,
        }).then((value)
        {
          commonViewModel.showSnackBar("New address has been saved", context);
        });
  }

  retrieveUserShipmentAddress()
  {
    return FirebaseFirestore.instance.collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("userAddress")
        .snapshots();
  }

  openGoogleMapWithGeographicPosition(double latitude, double longitude) async
  {
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await launchUrl(Uri.parse(googleMapUrl)))
    {
      await launchUrl(Uri.parse(googleMapUrl));
    }
    else
    {
      throw "Could not open google maps";
    }
  }
}