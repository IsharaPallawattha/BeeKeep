import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: primaryColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: dashboardText,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: logoutButtonText,
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 242, 255, 242),
      unselectedItemColor: const Color.fromARGB(255, 44, 43, 43),
      onTap: onTabSelected,
    );
  }
}
