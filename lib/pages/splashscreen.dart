import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7FAF6),
      body: Padding(
        padding: const EdgeInsets.only(top: 230, left: 100, right: 100),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/logotest.png',
                width: 140,
              ),
            ),
            SizedBox(height: 80),
            Text(
              'Sistem Pakar',
              style: GoogleFonts.roboto(
                color: Color(0xff000000),
                fontSize: 32,
              ),
            ),
            Text(
              'Ayam Broiler',
              style: GoogleFonts.roboto(
                color: Color(0xff000000),
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
