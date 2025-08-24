import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/utilities/utility.dart';
import 'package:http/http.dart' as http;

class PetDetailPage extends StatefulWidget {
  final String PetId;

  const PetDetailPage({
    super.key,
    required this.PetId,
  });

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  String name = '';

  String description = '';

  String image = '';

  String breed = '';

  String category = '';

  String age = '';

  String location = '';

  String vaccinated = '';
  bool isAdopted = false;

  Future<Map<String, dynamic>> getPetById(int id) async {
    final response =
        await http.get(Uri.parse('http://192.168.43.201:5172/api/Pets/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Pet not found');
    } else {
      throw Exception('Failed to load pet details');
    }
  }

  void fetchPetDetails(int id) async {
    try {
      Map<String, dynamic> pet = await getPetById(id);
      name = pet['PetName'] ?? 'Unknown';
      description = pet['Description'] ?? 'No description available';
      image = pet['ImageUrl'];
      breed = pet['Breed'] ?? 'Unknown';
      category = pet['Category'] ?? 'Unknown';
      age = pet['AgeYears'] ?? 'Unknown';
      location = pet['Location'] ?? 'Unknown';
      vaccinated = pet['Vaccinated'] ?? 'Unknown';
      isAdopted = pet['IsAdopted'] ?? false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendAdoptionRequest(String petId, String adopterContact) async {
    final url = Uri.parse(
        'http://192.168.43.201:5172/api/Pets/$petId/adopt?adoptercontact=$adopterContact');

    final response = await http.post(url);

    if (response.statusCode == 200) {
      print('Adoption request sent successfully: ${response.body}');
    } else {
      throw Exception('Failed to send adoption request: ${response.body}');
    }
  }

  @override
  void initState() {
    fetchPetDetails(int.parse(widget.PetId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pet Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            height20,

            // Pet Name
            Text(
              name,
              style: GoogleFonts.caveatBrush(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            height10,

            // Description
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),

            height20,

            // Adoption Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adoption Info",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  height10,
                  Row(
                    children: [
                      const Icon(Icons.cake, color: Colors.green),
                      width10,
                      Text(
                        "Age: $age years",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                  height10,
                  Row(
                    children: [
                      const Icon(Icons.wc, color: Colors.green),
                      width10,
                      Text(
                        "Gender: Male",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                  height10,
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green),
                      width10,
                      Text(
                        "Location: $location",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                  height10,
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green),
                      width10,
                      Text(
                        "Vaccinated: $vaccinated",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            height20,

            // Adopt Button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.pets,
                  color: Colors.black,
                ),
                style: ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(200, 55)),
                    elevation: MaterialStatePropertyAll(5),
                    backgroundColor: isAdopted
                        ? MaterialStatePropertyAll(Colors.grey)
                        : MaterialStatePropertyAll(greenshade)),
                onPressed: isAdopted
                    ? () {}
                    : () {
                        sendAdoptionRequest(widget.PetId,
                            FirebaseAuth.instance.currentUser!.email!);
                      },
                label: Text(
                  isAdopted ? "Adopted" : "Adopt Me",
                  style: GoogleFonts.caveatBrush(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
