import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petshop/utilities/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class AdoptedPetsScreen extends StatefulWidget {
  const AdoptedPetsScreen({super.key});

  @override
  State<AdoptedPetsScreen> createState() => _AdoptedPetsScreenState();
}

class _AdoptedPetsScreenState extends State<AdoptedPetsScreen> {
  List<dynamic> adoptedPets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAdoptedPets();
  }

  Future<void> fetchAdoptedPets() async {
    final userEmail = await FirebaseAuth.instance.currentUser!.email!;
    final url = Uri.parse(
        "http://192.168.43.201:5172/api/Pets/adopted?adopterEmail=$userEmail");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          adoptedPets = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        showDialog(
          context: context,
          builder: (context) =>
              AttentionAlert(mssg: 'Failed to load adopted pets'),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      showDialog(
        context: context,
        builder: (context) => AttentionAlert(mssg: 'Error: $e'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Adopted Pets')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : adoptedPets.isEmpty
              ? Center(child: Text('No adopted pets found.'))
              : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: adoptedPets.length,
                  itemBuilder: (context, index) {
                    final pet = adoptedPets[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              pet['ImageUrl'] ?? '',
                              fit: BoxFit.cover,
                              height: 120,
                              errorBuilder: (_, __, ___) =>
                                  Icon(Icons.pets, size: 80),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                pet['PetName'] ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: TextButton(
                                    onPressed: () async {
                                      final ownerEmail = pet['OwnerEmail'];
                                      final subject = Uri.encodeComponent(
                                          'Inquiry about ${pet['PetName']}');
                                      final body = Uri.encodeComponent(
                                          'Hello,\n\nI would like to get more information about ${pet['PetName']} that I adopted from you.\n\nThank you.');
                                      final mailtoUrl =
                                          'mailto:$ownerEmail?subject=$subject&body=$body';

                                      if (await canLaunchUrl(
                                          Uri.parse(mailtoUrl))) {
                                        await launchUrl(Uri.parse(mailtoUrl));
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AttentionAlert(
                                              mssg:
                                                  'Could not open email client.'),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Contact Previous Owner',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ))),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
