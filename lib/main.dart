import 'package:festival_diary_app/views/splash_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    FestivalDiaryApp(),
  );
}

//--------------------------------
class FestivalDiaryApp extends StatefulWidget {
  const FestivalDiaryApp({super.key});

  @override
  State<FestivalDiaryApp> createState() => _FestivalDiaryAppState();
}

class _FestivalDiaryAppState extends State<FestivalDiaryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
