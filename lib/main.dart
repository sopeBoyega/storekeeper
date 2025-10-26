import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storekeeper/screens/home.dart';

void main() {
  runApp(const MyApp());
}

final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 102, 6, 247),
    surface: const Color.fromARGB(255, 56, 49, 66),
  );

  final theme = ThemeData().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF2563EB),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      titleSmall: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
    ),
       elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFF2563EB)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(color: Colors.black),
      ),
    ),
      appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StoreKeeper App',
      theme: theme,
      home: HomeScreen(),
    );
  }
}
