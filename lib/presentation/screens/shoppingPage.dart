import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/presentation/screens/productdetailPage.dart';
import 'package:petshop/utilities/utility.dart';

class ShoppingScreen extends StatelessWidget {
  ShoppingScreen({super.key});

  final List<Map<String, String>> accessories = const [
    {'name': 'Dog Collar', 'image': 'assets/images/collar.webp'},
    {'name': 'Cat Carrier', 'image': 'assets/images/carrier.jpg'},
    {'name': 'Bird Cage', 'image': 'assets/images/cage.jpg'},
    {'name': 'Aquarium Decor', 'image': 'assets/images/aquarium.jpeg'},
  ];

  final List<Map<String, String>> food = const [
    {'name': 'Dog Food', 'image': 'assets/images/dogfood.webp'},
    {'name': 'Cat Food', 'image': 'assets/images/catfood.jpg'},
    {'name': 'Fish Flakes', 'image': 'assets/images/fishfood.jpg'},
    {'name': 'Bird Seeds', 'image': 'assets/images/birdfood.webp'},
  ];

  final List<Map<String, String>> toys = const [
    {'name': 'Chew Toy', 'image': 'assets/images/chew_toy.jpg'},
    {'name': 'Cat Teaser', 'image': 'assets/images/cat_teaser.jpg'},
    {'name': 'Ball Toy', 'image': 'assets/images/ball_toy.jpg'},
    {'name': 'Rabbit Tunnel', 'image': 'assets/images/tunnel.jpg'},
  ];

  final Map<String, List<Map<String, dynamic>>> categoryProducts = {
    'Dog Collar': [
      {
        'name': 'Leather Dog Collar',
        'image': 'assets/images/collar.webp',
        'price': 299,
      },
      {
        'name': 'Nylon Adjustable Collar',
        'image': 'assets/images/collar.webp',
        'price': 199,
      },
      {
        'name': 'Glow-in-the-Dark Collar',
        'image': 'assets/images/collar.webp',
        'price': 349,
      },
    ],
    'Cat Carrier': [
      {
        'name': 'Portable Cat Carrier',
        'image': 'assets/images/carrier.jpg',
        'price': 799,
      },
      {
        'name': 'Foldable Carrier Bag',
        'image': 'assets/images/carrier.jpg',
        'price': 599,
      },
    ],
    // Add more categories similarly...
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Shop for Your Pet 🛍️',
          style: GoogleFonts.caveatBrush(fontSize: 26, color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Pet Accessories'),
            height10,
            _buildGridSection(accessories),
            _buildSectionTitle('Pet Food'),
            height10,
            _buildGridSection(food),
            height20,
            _buildSectionTitle('Pet Toys'),
            height10,
            _buildGridSection(toys),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.caveatBrush(
        fontSize: 28,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildGridSection(List<Map<String, String>> items) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            final categoryName = item['name']!;
            final productList = categoryProducts[categoryName];

            if (productList != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryProductPage(
                    categoryName: categoryName,
                    products: productList,
                  ),
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade100, width: 2),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      item['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    item['name']!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
