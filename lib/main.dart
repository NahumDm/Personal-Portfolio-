import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'widgets/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Nahom Desta - Portfolio',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                primary: themeProvider.isDarkMode ? Colors.black : Colors.white,
                background:
                    themeProvider.isDarkMode ? Colors.black : Colors.white,
                surface: themeProvider.isDarkMode ? Colors.black : Colors.white,
              ),
              scaffoldBackgroundColor:
                  themeProvider.isDarkMode ? Colors.black : Colors.white,
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData(
                  brightness:
                      themeProvider.isDarkMode
                          ? Brightness.dark
                          : Brightness.light,
                ).textTheme,
              ),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
