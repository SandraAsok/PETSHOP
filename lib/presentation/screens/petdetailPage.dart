import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/utilities/utility.dart';

class PetDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;

  const PetDetailPage({
    super.key,
    required this.name,
    required this.image,
    required this.description,
  });

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
                        "Age: 2 years",
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
                        "Location: Pet Shelter, Mumbai",
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
                        "Vaccinated: Yes",
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
                    backgroundColor: MaterialStatePropertyAll(greenshade)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Adoption Request Sent! 🐾"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                label: Text(
                  "Adopt Me",
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
