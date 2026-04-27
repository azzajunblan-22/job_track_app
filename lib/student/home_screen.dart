import 'package:flutter/material.dart';
import '../../localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppLocale.tr(context, "Home Screen (Coming Soon...)"),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}