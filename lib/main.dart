import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gram_eats/provider/address_changer.dart';
import 'package:gram_eats/provider/cart_item_counter.dart';
import 'package:gram_eats/provider/total_amount.dart';
import 'package:gram_eats/view/splashScreen/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/global_vars.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission)
      {
        if (valueOfPermission)
          {
            Permission.locationWhenInUse.request();
          }
      }
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
      ],
      child: MaterialApp(
        title: 'Gram Eats',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          ),
        ),
        // theme: ThemeData(
        //   useMaterial3: true,
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        // ),
        home: MySplashScreen(),
      ),
    );
  }
}

