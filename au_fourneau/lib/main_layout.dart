import 'package:flutter/material.dart';
import 'widgets/app_top_bar.dart';
import 'widgets/app_bottom_nav.dart';
import 'pages/home_page.dart';
import 'pages/profil_page.dart';

class MainLayout extends StatefulWidget {
    final bool isCook;
  const MainLayout({super.key, required this.isCook,});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  List<Widget> get _pages {
    if (widget.isCook) {
      return const [
        HomePage(),
        Placeholder(),
        Placeholder(),
        ProfilPage(),
      ];
    } else {
      return const [
        HomePage(),
        ProfilPage(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        isCook: widget.isCook,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}