import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/presentation/functions/firebase_functions.dart';
import 'package:petshop/presentation/screens/adoptedList.dart';
import 'package:petshop/presentation/screens/mypets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
            ),
            child: Text(
              'Welcome!',
              style: GoogleFonts.caveatBrush(
                fontSize: 28,
                color: Colors.green[900],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.green),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.green),
            title: const Text('My Additions'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyPetsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.pets, color: Colors.green),
            title: const Text('My Adoptions'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdoptedPetsScreen()));
            },
          ),
          ListTile(
              leading: const Icon(Icons.help, color: Colors.green),
              title: const Text('Help & Support'),
              onTap: () async {
                final adminEmail = 'apphiveofficial@gmail.com';
                final subject =
                    Uri.encodeComponent('Inquiry about FurEver Home App');
                final body = Uri.encodeComponent('Enter your message here...');
                final mailtoUrl =
                    'mailto:$adminEmail?subject=$subject&body=$body';
                if (await canLaunchUrl(Uri.parse(mailtoUrl))) {
                  await launchUrl(Uri.parse(mailtoUrl));
                }
              }),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.green),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.green),
            title: const Text('Logout'),
            onTap: () {
              signout(context);
            },
          ),
        ],
      ),
    );
  }
}
