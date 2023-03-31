import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/screens/bag_screen.dart';
import 'package:e_commerce_app/screens/catelog/catelog_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/profile_screen.dart';
import 'package:e_commerce_app/screens/shop_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _index = 0;
  List page = [
    HomeScreen(),
    ShopScreen(),
    BagScreen(),
    Placeholder(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        currentIndex: _index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home_filled,
                color: MyColors.btncolor,
              ),
              icon: Icon(Icons.home_outlined),
              label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.shopping_cart_sharp,
                color: MyColors.btncolor,
              ),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Shop'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.shopping_bag_sharp,
                color: MyColors.btncolor,
              ),
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Bag'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.favorite_sharp,
                color: MyColors.btncolor,
              ),
              icon: Icon(Icons.favorite_outline),
              label: 'Favorite'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_2_sharp,
                color: MyColors.btncolor,
              ),
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile'),
        ],
      ),
      body: page[_index],
    );
  }
}
