import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 380,
      color: const Color(0xffFFFFFF),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        'images/Vector-11.png',
                        scale: .8,
                      ),
                    ),
                    const Positioned(
                      top: 8,
                      left: 6,
                      child: Center(
                        child: Text(
                          'EC',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Elbrit Central ",
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff262930),
                              ),
                            ),
                            TextSpan(
                              text:
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. A tellus nulla viverra gravida tristique. Sed lobortis dui ullamcorper quisque proin in eget cursus.",
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff262930),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '20 hours ago',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff8394AA),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 4,
            color: Color(0xffE9EEF3),
          )
        ],
      ),
    );
  }
}
