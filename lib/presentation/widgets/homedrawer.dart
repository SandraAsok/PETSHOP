import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/presentation/functions/firebase_functions.dart';

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
            leading: Icon(Icons.home, color: Colors.green),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.green),
            title: Text('My Additions'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.pets, color: Colors.green),
            title: Text('My Adoptions'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.green),
            title: Text('Help & Support'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.green),
            title: Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.green),
            title: Text('Logout'),
            onTap: () {
              signout(context);
            },
          ),
        ],
      ),
    );
  }
}
