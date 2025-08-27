// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:petshop/presentation/widgets/custom_bottonNav.dart';
import 'package:petshop/utilities/utility.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  String petName = '';
  String ownerName = '';
  String contactNumber = '';
  String breed = "";
  String location = '';
  int age = 0;
  bool isVaccinated = false;
  String gender = '--select--';
  String description = '';
  int categoryId = -1;
  File? imageFile;

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future addPet() async {
    try {
      final response = await http
          .post(Uri.parse("http://192.168.43.201:5172/api/Pets"), body: {
        "petName": petName,
        "ownerEmail": FirebaseAuth.instance.currentUser!.email!,
        "ownerName": ownerName,
        "ownerContact": contactNumber,
        "breed": breed,
        "category": getCategoryName(categoryId),
        "ImageUrl": imageFile!.path,
        "vaccinated": isVaccinated.toString(),
        "description": description,
        "ageYears": age.toString(),
        "location": location
      });

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (context) =>
                const SuccessAlert(mssg: "Pet added successfully!"));

        petName = '';
        ownerName = '';
        contactNumber = '';
        breed = '';
        isVaccinated = false;
        description = '';
        age = 0;
        location = '';

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MainNavigationScreen()));
      } else {
        showDialog(
            context: context,
            builder: (context) => AttentionAlert(
                mssg:
                    "Failed to add pet. | status code : ${response.statusCode}"));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AttentionAlert(mssg: "Attention : $e"));
    }
  }

  String getCategoryName(int id) {
    switch (id) {
      case 1:
        return "Dog";
      case 2:
        return "Cat";
      case 3:
        return "Bird";
      case 4:
        return "Rabbit";
      case 5:
        return "Fish";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Your Pet',
          style: GoogleFonts.caveatBrush(fontSize: 26, color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(
                  "Pet Name", (val) => petName = val ?? '', TextInputType.name),
              buildTextField("Owner Name", (val) => ownerName = val ?? '',
                  TextInputType.name),
              buildTextField("Contact Number",
                  (val) => contactNumber = val ?? '', TextInputType.phone),
              buildTextField("Location", (val) => location = val ?? '',
                  TextInputType.text),
              buildTextField(
                  "Breed", (val) => breed = val ?? '', TextInputType.text),
              buildTextField(
                "Age",
                (val) => age = int.tryParse(val ?? '0') ?? 0,
                TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  value: gender,
                  items: ['--select--', 'Male', 'Female'].map((g) {
                    return DropdownMenuItem(value: g, child: Text(g));
                  }).toList(),
                  onChanged: (val) => setState(() => gender = val!),
                  decoration: dropdownDecoration("Gender"),
                ),
              ),
              SwitchListTile(
                title: const Text("Vaccinated?"),
                value: isVaccinated,
                onChanged: (val) => setState(() => isVaccinated = val),
              ),
              buildTextField("Description", (val) => description = val ?? '',
                  TextInputType.streetAddress),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<int>(
                  value: categoryId,
                  decoration: dropdownDecoration("Pet Category"),
                  items: const [
                    DropdownMenuItem(value: -1, child: Text("--select--")),
                    DropdownMenuItem(value: 1, child: Text("Dog")),
                    DropdownMenuItem(value: 2, child: Text("Cat")),
                    DropdownMenuItem(value: 3, child: Text("Bird")),
                    DropdownMenuItem(value: 4, child: Text("Rabbit")),
                    DropdownMenuItem(value: 5, child: Text("Fish")),
                  ],
                  onChanged: (val) => setState(() => categoryId = val!),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon:
                        const Icon(Icons.image, color: Colors.white, size: 20),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(200, 55),
                      elevation: 5,
                    ),
                    onPressed: pickImage,
                    label: Text(
                      'Pick Image',
                      style: GoogleFonts.caveatBrush(
                          color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (imageFile != null)
                    Expanded(
                      child: Text(
                        imageFile!.path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: addPet,
                child: Text(
                  'Submit',
                  style: GoogleFonts.caveatBrush(
                      color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
