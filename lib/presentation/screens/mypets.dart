import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:petshop/utilities/utility.dart';

class MyPetsScreen extends StatefulWidget {
  final String email;
  const MyPetsScreen({super.key, required this.email});

  @override
  _MyPetsScreenState createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  late Future<List<dynamic>> petsFuture;

  Future<List<dynamic>> getUserPets(String email) async {
    final response = await http.get(
      Uri.parse('http://192.168.43.201:5172/api/pets/user/$email'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pets');
    }
  }

  Future<void> deletePet(int petId) async {
    final url = Uri.parse(
        "http://<YOUR_API_BASE_URL>/api/pets/$petId"); // Replace with your API base URL

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          petsFuture = getUserPets(widget.email);
        });
        showDialog(
          context: context,
          builder: (context) =>
              SuccessAlert(mssg: data['Message'] ?? 'Pet deleted successfully'),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AttentionAlert(
              mssg: 'Failed to delete pet: ${response.statusCode}'),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AttentionAlert(mssg: 'Error: $e'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    petsFuture = getUserPets(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('My Pets', style: TextStyle(color: Colors.green))),
      body: FutureBuilder<List<dynamic>>(
        future: petsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No pets added yet.'));
          } else {
            final pets = snapshot.data!;
            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(pet['ImageUrl']),
                    title: Text(pet['PetName']),
                    subtitle: Text(pet['category']),
                    trailing: IconButton(
                        onPressed: () => deletePet(pet['PetId']),
                        icon: Icon(Icons.delete, color: Colors.red)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
