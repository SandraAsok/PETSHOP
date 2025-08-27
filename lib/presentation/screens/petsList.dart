import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PetsListScreen extends StatefulWidget {
  final String category;
  const PetsListScreen({super.key, required this.category});

  @override
  State<PetsListScreen> createState() => _PetsListScreenState();
}

class _PetsListScreenState extends State<PetsListScreen> {
  bool isLoading = true;
  bool isError = false;
  List<Map<String, dynamic>> pets = [];

  @override
  void initState() {
    super.initState();
    fetchPets(widget.category);
  }

  Future<void> fetchPets(String category) async {
    try {
      final encodedCategory = Uri.encodeComponent(category);
      final response = await http.get(
        Uri.parse(
            "http://192.168.43.201:5172/api/pets/category/$encodedCategory"),
      );

      log("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final petsList =
            data.map((item) => Map<String, dynamic>.from(item)).toList();

        setState(() {
          pets = petsList;
          isLoading = false;
        });
      } else {
        setState(() {
          pets = [];
          isLoading = false;
        });
      }
    } catch (e, stack) {
      log("Error fetching pets: $e\n$stack");
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : isError
              ? const Center(child: Text("Failed to load pets"))
              : pets.isEmpty
                  ? const Center(child: Text("No pets available"))
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: pets.length,
                      itemBuilder: (context, index) {
                        final pet = pets[index];
                        final ImageUrl = pet['image'] ?? ''; // safe access
                        final petName = pet['PetName'] ?? 'Unknown';

                        return GestureDetector(
                          onTap: () {
                            // Navigate to PetDetailPage if needed
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: ImageUrl.isNotEmpty
                                        ? Image.network(
                                            ImageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                const Icon(Icons.broken_image,
                                                    size: 50),
                                          )
                                        : const Icon(Icons.image, size: 50),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    petName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
