import 'package:elbrit_central/controllers/app_bar.dart';
import 'package:elbrit_central/controllers/notification_tile.dart';
import 'package:elbrit_central/views/price_list.dart';
import 'package:elbrit_central/views/profile.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List _notifications = [
    'Hello'
        'Hello',
    'Hello',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 3,
          flexibleSpace: SafeArea(
            child: Container(
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: NewAppBar(),
              ),
            ),
          ),
        ),
        body: Container(
          color: const Color(0xffF8FAFC),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Today',
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff8394AA),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return NotificationTile();
                    }),
                Container(
                  color: Colors.transparent,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'This week',
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff8394AA),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return NotificationTile();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
