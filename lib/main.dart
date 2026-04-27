import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main_navigation.dart';
import 'localization.dart';

final AppLocale appLocale = AppLocale();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LocalizationWrapper(
      localeController: appLocale,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Job Track',
            locale: appLocale.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: const Color(0xFFEBEEF4),
              primaryColor: const Color(0xFF229BD8),
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF229BD8)),
              fontFamily: 'Roboto', // Default but ensuring consistency
              textTheme: const TextTheme(
                titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                bodyMedium: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
            home: const MainNavigation(),
          );
        }
      ),
    );
  }
}