import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/view/widgets/simple_text_field.dart';
import '../../global/global_vars.dart';

class SaveAddressScreen extends StatefulWidget {
  const SaveAddressScreen({super.key});

  @override
  State<SaveAddressScreen> createState() => _SaveAddressScreenState();
}

class _SaveAddressScreenState extends State<SaveAddressScreen>
{
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemark;
  Position? position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Address"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Save Address"),
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add_location),
        onPressed: () async
        {
          if(formKey.currentState!.validate())
          {
            await addressViewModel.saveShipmentAddressToDatabase(
              _name.text.trim(),
              state.text.trim(),
              completeAddress.text.trim(),
              _phoneNumber.text.trim(),
              flatNumber.text.trim(),
              city.text.trim(),
              latitudeValue,
              longitudeValue,
              context,
            );

            formKey.currentState!.reset();
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 6,),

            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                size: 35,
              ),
              title: SizedBox(
                width: 250,
                child: TextField(
                  // style: const TextStyle(
                  //   color: Colors.black
                  // ),
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: "Enter your address",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6,),

            ElevatedButton.icon(
              label: const Text(
                "Get My Location"
              ),
              icon: const Icon(Icons.location_on),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white70),
                ),
              ),
              onPressed: () async
              {
                await commonViewModel.getCurrentLocation();
              },
            ),

            Form(
              key: formKey,
              child: Column(
                children: [

                  SimpleTextField(
                    hint: "Name",
                    controller: _name,
                  ),

                  SimpleTextField(
                    hint: "Phone Number",
                    controller: _phoneNumber,
                  ),

                  SimpleTextField(
                    hint: "City",
                    controller: city,
                  ),

                  SimpleTextField(
                    hint: "State",
                    controller: state,
                  ),

                  SimpleTextField(
                    hint: "Address Line",
                    controller: flatNumber,
                  ),

                  SimpleTextField(
                    hint: "Complete Address",
                    controller: completeAddress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
