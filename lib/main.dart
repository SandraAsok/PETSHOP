import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_options.dart';
import 'package:petshop/presentation/screens/landingPage.dart';
import 'package:petshop/presentation/widgets/custom_bottonNav.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: SafeArea(child: Splash()),
    debugShowCheckedModeBanner: false,
  ));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool finalEmail = false;

  Future getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isEmail = prefs.getBool('email');
    setState(() {
      finalEmail = isEmail!;
    });
  }

  @override
  void initState() {
    getUserData().whenComplete(() {
      if (finalEmail == false) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LandingPage()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MainNavigationScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
