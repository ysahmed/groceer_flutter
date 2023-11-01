import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      'assets/images/groceries.png',
                      height: height * 0.4,
                    ),
                    // app name
                    Text(
                      "Groceer",
                      style: GoogleFonts.leckerliOne(
                        color: Colors.green[900],
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        height: 0.8,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            blurRadius: 30,
                            offset: Offset(4, 8),
                          ),
                          Shadow(
                            color: Color.fromARGB(255, 240, 206, 200)!,
                            blurRadius: 2,
                            offset: Offset(-2, 2),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // text
                Text(
                  "We deliver\ngroceries at your\ndoorstep",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),

                // small text
                const Text(
                  "Groceer gives you fresh vegetables and fruits,Order fresh items from groceer.",
                  style: TextStyle(color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),

                // button
                MaterialButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      )),
                  color: Colors.lightBlue[300],
                  shape: const StadiumBorder(),
                  minWidth: width * 0.7,
                  height: height * 0.08,
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
