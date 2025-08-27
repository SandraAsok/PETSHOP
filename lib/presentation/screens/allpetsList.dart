import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:petshop/presentation/screens/petdetailPage.dart';
import 'package:petshop/utilities/utility.dart';

class GetAllPetsScreen extends StatefulWidget {
  const GetAllPetsScreen({Key? key}) : super(key: key);

  @override
  _GetAllPetsScreenState createState() => _GetAllPetsScreenState();
}

class _GetAllPetsScreenState extends State<GetAllPetsScreen> {
  List pets = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAllPets();
  }

  Future<void> fetchAllPets() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.43.201:5172/api/Pets'));
      if (response.statusCode == 200) {
        setState(() {
          pets = json.decode(response.body);
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AttentionAlert(mssg: 'Failed to load pets'),
        );
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AttentionAlert(mssg: 'Error: $e'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Pets",
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.green)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.green),
        elevation: 0,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            PetDetailPage(PetId: pet['PetId']),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.network(
                            pet['ImageUrl'] ??
                                'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            height: 120.0 + (index % 4) * 35.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              pet['PetName'] ?? 'Unknown',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
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
