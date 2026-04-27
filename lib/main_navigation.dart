import 'package:flutter/material.dart';
import '../localization.dart';
// تأكدي من صحة المسارات حسب مجلدات مشروعك
import 'student/home_screen.dart';
import 'student/applications_screen.dart';
import 'student/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1; // يبدأ بالهوم افتراضياً

  // قائمة الصفحات المرتبطة بالأيقونات
  final List<Widget> _screens = [
    const ApplicationsScreen(),
    const HomeScreen(),
     ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // الجسم يتغير تلقائياً حسب العنصر المختار
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF229BD8),
        unselectedItemColor: const Color(0xFF7E848E),
        type: BottomNavigationBarType.fixed, // يضمن ثبات الأيقونات
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_outlined),
            label: AppLocale.tr(context, "Applications"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: AppLocale.tr(context, "Home"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: AppLocale.tr(context, "Profile"),
          ),
        ],
      ),
    );
  }
}