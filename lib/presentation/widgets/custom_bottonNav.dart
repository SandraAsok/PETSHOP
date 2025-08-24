// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:petshop/presentation/screens/addPet.dart';
import 'package:petshop/presentation/screens/homePage.dart';
import 'package:petshop/presentation/screens/shoppingPage.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    ShoppingScreen(),
    const AddPetScreen(),
    const Center(child: Text('Saved')),
    const Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(
              icon: Icons.home,
              isActive: currentIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            _BottomNavItem(
              icon: Icons.shopping_bag_outlined,
              isActive: currentIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            _BottomNavItem(
              icon: Icons.add,
              isActive: currentIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            _BottomNavItem(
              icon: Icons.bookmark_outline,
              isActive: currentIndex == 3,
              onTap: () => onItemTapped(3),
            ),
            _BottomNavItem(
              icon: Icons.person_outline,
              isActive: currentIndex == 4,
              onTap: () => onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isActive ? Colors.green : Colors.grey,
        size: 28,
      ),
    );
  }
}
