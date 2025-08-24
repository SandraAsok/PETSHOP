import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/utilities/utility.dart';

class CategoryProductPage extends StatelessWidget {
  final String categoryName;
  final List<Map<String, dynamic>> products;

  const CategoryProductPage({
    super.key,
    required this.categoryName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        title: Text(
          categoryName,
          style: GoogleFonts.caveatBrush(fontSize: 26, color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade100),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        product['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          product['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        height10,
                        Row(
                          children: [
                            Text("₹${product['price']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                )),
                            Spacer(),
                            Icon(Icons.shopping_bag,
                                color: Colors.green, size: 25),
                            Spacer(),
                            Icon(Icons.shopping_cart,
                                color: Colors.red, size: 25),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
