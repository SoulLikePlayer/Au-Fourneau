import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isCook;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isCook,
  });

  @override
  Widget build(BuildContext context) {

    final items = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: "Ateliers",
      ),

      if (isCook)
        const BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: "Marché",
        ),

      if (isCook)
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: "Créer",
        ),

      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Profil",
      ),
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: items,
    );
  }
}