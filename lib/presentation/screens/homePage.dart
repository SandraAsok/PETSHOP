import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/presentation/screens/petdetailPage.dart';
import 'package:petshop/presentation/screens/petsList.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:petshop/presentation/widgets/homedrawer.dart';
import 'package:petshop/utilities/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedLocation;
  final List<String> locations = ['location 1', 'location 2', 'location 3'];

  final List<String> bannerImages = [
    'assets/images/ad2.jpg',
    'assets/images/ad3.jpg',
    'assets/images/ad4.jpg',
    'assets/images/ad5.avif',
  ];

  final List<Map<String, String>> petList = [
    {'name': 'Dog', 'image': 'assets/images/dog1.png'},
    {'name': 'Cat', 'image': 'assets/images/cat1.png'},
    {'name': 'Rabbit', 'image': 'assets/images/rabbit1.png'},
    {'name': 'Bird', 'image': 'assets/images/bird1.png'},
    {'name': 'Fish', 'image': 'assets/images/fish1.png'},
  ];

  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const HomeDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Search by location",
                  labelStyle: GoogleFonts.caveatBrush(fontSize: 22),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
              height10,
              Row(
                children: [
                  Text(
                    "Waiting For You !",
                    style: GoogleFonts.caveatBrush(fontSize: 25),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See More...",
                      style: GoogleFonts.caveatBrush(
                          fontSize: 22, color: Colors.green),
                    ),
                  ),
                ],
              ),
              height10,
              CarouselSlider.builder(
                itemCount: bannerImages.length,
                carouselController: _controller,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      bannerImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: bannerImages.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.green,
                    dotColor: Colors.green.withOpacity(0.3),
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                  onDotClicked: (index) => _controller.animateToPage(index),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Pick a Friend 🐾",
                style: GoogleFonts.caveatBrush(fontSize: 28),
              ),
              height20,
              MasonryGridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                itemCount: petList.length,
                itemBuilder: (context, index) {
                  final pet = petList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  PetsListScreen(category: pet['name']!),
                              fullscreenDialog: true));
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
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: Image.asset(
                              pet['image']!,
                              fit: BoxFit.cover,
                              height: 120.0 + (index % 4) * 35.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                pet['name']!,
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
            ],
          ),
        ),
      ),
    );
  }
}
