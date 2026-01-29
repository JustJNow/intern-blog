import 'package:flutter/material.dart';

class NewspaperTheme {
  // Colors
  static const Color paperBackground = Color(0xFFF5F1E6); // Beige/Parchment
  static const Color inkBlack = Color(0xFF2A2A2A); // Soft black for text
  static const Color oldPaperBorder = Color(0xFF444444); // Dark grey for lines

  static TextTheme textTheme = const TextTheme(
    // Big Headlines (Playfair)
    displayLarge: TextStyle(
      fontFamily: 'Playfair Display',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: inkBlack,
    ),
    // Article Titles (Playfair)
    headlineSmall: TextStyle(
      fontFamily: 'Playfair Display',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: inkBlack,
      height: 1.2,
    ),
    // Body Text (Lora)
    bodyMedium: TextStyle(
      fontFamily: 'Lora',
      fontSize: 16,
      color: inkBlack,
      height: 1.5,
    ),
    // Captions/Dates
    labelSmall: TextStyle(
      fontFamily: 'Lora',
      fontSize: 12,
      fontStyle: FontStyle.italic,
      color: Colors.grey,
    ),
  );

  static ThemeData get theme {
    return ThemeData(
      primaryColor: inkBlack,
      scaffoldBackgroundColor: paperBackground,
      textTheme: textTheme,
      
      appBarTheme: const AppBarTheme(
        backgroundColor: paperBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: inkBlack),
        titleTextStyle: TextStyle(
          fontFamily: 'Playfair Display', 
          fontSize: 24, 
          fontWeight: FontWeight.bold, 
          color: inkBlack
        ),
        shape: Border(bottom: BorderSide(color: oldPaperBorder, width: 2)),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: false,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: oldPaperBorder),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: inkBlack, width: 2),
        ),
        labelStyle: TextStyle(fontFamily: 'Lora', color: oldPaperBorder),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: inkBlack,
          foregroundColor: paperBackground,
          textStyle: const TextStyle(fontFamily: 'Playfair Display', fontWeight: FontWeight.bold),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
    );
  }
}