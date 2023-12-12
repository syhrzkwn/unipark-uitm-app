import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/features/core/pages/home_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    Center(
      child: Text("Parking"),
    ),
    Center(
      child: Text("Inbox"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 65.0,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: textColor2, width: 0.5)),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            iconSize: 30.0,
            selectedLabelStyle: const TextStyle(fontSize: 12.0),
            selectedItemColor: dark ? whiteColor : primaryColor,
            unselectedItemColor: dark ? whiteColor.withOpacity(0.7) : textColor2,
            items: <BottomNavigationBarItem> [
              BottomNavigationBarItem(icon: _selectedIndex==0 ? const Icon(Icons.home_rounded) : const Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(icon: _selectedIndex==1 ? const Icon(Icons.directions_car_rounded) : const Icon(Icons.directions_car_filled_outlined), label: "Parking"),
              BottomNavigationBarItem(icon: _selectedIndex==2 ? const Icon(Icons.inbox_rounded) : const Icon(Icons.inbox_outlined), label: "Inbox"),
              BottomNavigationBarItem(icon: _selectedIndex==3 ? const Icon(Icons.account_circle_rounded) : const Icon(Icons.account_circle_outlined), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
