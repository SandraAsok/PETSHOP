import 'package:flutter/material.dart';

class LandingContainer extends StatelessWidget {
  final String assetUrl;
  final Color colorshade;
  final double h;

  const LandingContainer({
    super.key,
    required this.assetUrl,
    required this.colorshade,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(
        color: colorshade,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Image.asset(assetUrl),
          ),
        ],
      ),
    );
  }
}
