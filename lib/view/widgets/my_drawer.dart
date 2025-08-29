import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/global/global_vars.dart';
import 'package:gram_eats/view/mainScreens/home_screen.dart';
import 'package:gram_eats/view/splashScreen/splash_screen.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                //image
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(81)),
                  elevation: 8,
                  child: SizedBox(
                    height: 158,
                    width: 158,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        sharedPreferences!.getString("imageUrl").toString(),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                Text(
                  sharedPreferences!.getString("name").toString(),
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12,),
          
          //body
          Column(
            children: [

              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
                },
              ),

              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text("Orders"),
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
                },
              ),

              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text("Search Restaurants"),
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
                },
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("History"),
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
                },
              ),

              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.share_location),
                title: const Text("Update Address"),
                onTap: ()
                {
                  //
                },
              ),

              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: ()
                {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
                },
              ),

            ],
          ),

        ],
      ),
    );
  }
}