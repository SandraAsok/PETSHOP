import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/presentation/screens/authentication.dart';
import 'package:petshop/presentation/widgets/landingcontainer.dart';
import 'package:petshop/utilities/utility.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LandingContainer(
                      assetUrl: "assets/images/rabbit1.png",
                      colorshade: purpleshade,
                      h: MediaQuery.of(context).size.height / 2.3),
                  LandingContainer(
                      assetUrl: "assets/images/cat1.png",
                      colorshade: greenshade,
                      h: MediaQuery.of(context).size.height / 3),
                  LandingContainer(
                      assetUrl: "assets/images/bird1.png",
                      colorshade: redshade,
                      h: MediaQuery.of(context).size.height / 2.5),
                  LandingContainer(
                      assetUrl: "assets/images/dog1.png",
                      colorshade: blueshade,
                      h: MediaQuery.of(context).size.height / 3.3),
                  LandingContainer(
                      assetUrl: "assets/images/fish1.png",
                      colorshade: pinkshade,
                      h: MediaQuery.of(context).size.height / 2),
                ],
              ),
              height50,
              Text(
                "Find Your Favourite \nPet Close to You !",
                style: GoogleFonts.caveatBrush(
                    color: landingfont,
                    fontWeight: FontWeight.w200,
                    fontSize: 30),
              ),
              height20,
              Text(
                "Find Your new bestfriend at our store!\nWe have a wide selection of lovable and cute pets\nready for adoption!!",
                style: GoogleFonts.caveatBrush(
                    color: landingsubfont, fontSize: 20),
              ),
              height50,
              ElevatedButton(
                  style: btnStyle,
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => LoginScreen(),
                            fullscreenDialog: true));
                  },
                  child: Text(
                    "Explore",
                    style: GoogleFonts.caveatBrush(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
