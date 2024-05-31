
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHero extends StatelessWidget {
  const CustomHero({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/hero.png"))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 44, right: 16, left: 16, bottom: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios, color: Colors.white),
                        Row(
                          children: [
                            Icon(
                              FeatherIcons.search,
                              color: Colors.white,
                            ),
                            SizedBox(width: 16),
                            Icon(
                              FeatherIcons.heart,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Restaurante",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                Text(
                                  " Comida Gourmet ",
                                  style: GoogleFonts.inter(
                                      fontSize: 12, color: Colors.white),
                                ),
                                const CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.white,
                                ),
                                Text(
                                  " Chef ",
                                  style: GoogleFonts.inter(
                                      fontSize: 12, color: Colors.white),
                                ),
                                const CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.white,
                                ),
                                
                                
                                
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        
                      ],
                    )
                  ]),
            ),
          );
  }
}