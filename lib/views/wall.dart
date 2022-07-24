import 'dart:math';

import 'package:elbrit_central/components/gradient_create.dart';
import 'package:elbrit_central/controllers/app_bar.dart';
import 'package:elbrit_central/models/wall_info.dart';
import 'package:elbrit_central/services/api.dart';

import 'package:elbrit_central/views/notification.dart';
import 'package:elbrit_central/views/products.dart';
import 'package:elbrit_central/views/profile.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

class WallPage extends StatefulWidget {
  WallPage({Key? key}) : super(key: key);

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  List<WallModel> wallModels = [];
  List<WallModel> pinnedWallModel = [];

  bool isLoading = false;
  @override
  void initState() {
    _controller =
        VideoPlayerController.network("https://elbrit.devcorn.live/uploads/");
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
    getWallInfo();
  }

  Future<void> getWallInfo() async {
    setState(() {
      isLoading = true;
    });

    wallModels.clear();
    pinnedWallModel.clear();
    final List<WallModel> walls = await Api().getWallData();

    for (final WallModel wallModel in walls) {
      if (wallModel.pinPost == "1") {
        pinnedWallModel.add(wallModel);
      } else {
        wallModels.add(wallModel);
      }
    }

    print(wallModels);
    print(pinnedWallModel);
    setState(() {
      isLoading = false;
    });
  }

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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: const Color(0xffEFF3F8),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 380,
                              decoration: const BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                SizedBox(
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
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Elbrit Central',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff262930),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (pinnedWallModel[index].pinPost ==
                                            "1")
                                          Row(
                                            children: [
                                              Image.asset(
                                                'images/Vector-12.png',
                                                scale: 1,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'Pinned Post',
                                                style: GoogleFonts.dmSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff8394AA),
                                                ),
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                  if (pinnedWallModel[index].image!.length == 1)
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      child: pinnedWallModel.isNotEmpty
                                          ? ExtendedImage.network(
                                              "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![0]}",
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset('images/img_1.png',
                                              fit: BoxFit.fill),
                                    ),
                                  if (pinnedWallModel[index].image!.isEmpty ==
                                      2)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 300,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                14.0),
                                                      ),
                                                    ),
                                                    child: pinnedWallModel
                                                            .isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![0]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_11.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 300,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: pinnedWallModel
                                                            .isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![1]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_12.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (pinnedWallModel[index].image!.length == 3)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 148,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    14.0),
                                                          ),
                                                        ),
                                                        child: pinnedWallModel
                                                                .isNotEmpty
                                                            ? ExtendedImage
                                                                .network(
                                                                "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![0]}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                'images/img_10.png',
                                                                fit: BoxFit
                                                                    .fill),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Container(
                                                        height: 148,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    14.0),
                                                          ),
                                                        ),
                                                        child: pinnedWallModel
                                                                .isNotEmpty
                                                            ? ExtendedImage
                                                                .network(
                                                                "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![1]}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                'images/img_11.png',
                                                                fit: BoxFit
                                                                    .fill),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 300,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: pinnedWallModel
                                                            .isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![2]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_12.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (pinnedWallModel[index].image!.length == 4)
                                    Container(
                                      width: 380,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),

                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: pinnedWallModel
                                                            .isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![0]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_2.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: pinnedWallModel
                                                            .isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![1]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_3.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: pinnedWallModel
                                                            .isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![2]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_4.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: pinnedWallModel
                                                            .isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${pinnedWallModel[index].image![3]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_5.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (pinnedWallModel[index].video?.length == 1)
                                    Stack(
                                      children: [
                                        Container(
                                          width: 380,
                                          child: FutureBuilder(
                                            future:
                                                _initializeVideoPlayerFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return AspectRatio(
                                                  aspectRatio: _controller
                                                      .value.aspectRatio,
                                                  child:
                                                      VideoPlayer(_controller),
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            top: 0,
                                            bottom: 10,
                                            child: FloatingActionButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_controller
                                                      .value.isPlaying) {
                                                    _controller.pause();
                                                  } else {
                                                    _controller.play();
                                                  }
                                                });
                                              },
                                            )),
                                      ],
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 8),
                                    child: Text(
                                      pinnedWallModel.isNotEmpty
                                          ? pinnedWallModel[index].details!
                                          : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. A tellus nulla viverra gravida tristique. Sed lobortis dui ullamcorper quisque proin in eget cursus.',
                                      textAlign: TextAlign.left,
                                      maxLines: 100,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1.1,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff262930),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 20,
                                    padding: const EdgeInsets.only(
                                        left: 12, bottom: 10),
                                    child: Text(
                                      pinnedWallModel.isEmpty
                                          ? pinnedWallModel[index].publishedAt!
                                          : '20 hours ago',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff8394AA),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 30,
                            );
                          },
                          itemCount: pinnedWallModel.length),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 380,
                              decoration: const BoxDecoration(
                                color: Color(0xffFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                SizedBox(
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
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Elbrit Central',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff262930),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (wallModels[index].pinPost == "1")
                                          Row(
                                            children: [
                                              Image.asset(
                                                'images/Vector-12.png',
                                                scale: 1,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'Pinned Post',
                                                style: GoogleFonts.dmSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff8394AA),
                                                ),
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                  if (wallModels[index].image!.length == 1)
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      child: wallModels.isNotEmpty
                                          ? ExtendedImage.network(
                                              "https://elbrit.devcorn.live/uploads/${wallModels[index].image![0]}",
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset('images/img_1.png',
                                              fit: BoxFit.fill),
                                    ),
                                  if (wallModels[index].image!.length == 2)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 300,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                14.0),
                                                      ),
                                                    ),
                                                    child: wallModels.isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${wallModels[index].image![0]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_11.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 300,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: wallModels.isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${wallModels[index].image![1]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_12.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (wallModels[index].image!.length == 3)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 148,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    14.0),
                                                          ),
                                                        ),
                                                        child: wallModels
                                                                .isNotEmpty
                                                            ? ExtendedImage
                                                                .network(
                                                                "https://elbrit.devcorn.live/uploads/${wallModels[index].image![0]}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                'images/img_10.png',
                                                                fit: BoxFit
                                                                    .fill),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Container(
                                                        height: 148,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    14.0),
                                                          ),
                                                        ),
                                                        child: wallModels
                                                                .isNotEmpty
                                                            ? ExtendedImage
                                                                .network(
                                                                "https://elbrit.devcorn.live/uploads/${wallModels[index].image![1]}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                'images/img_11.png',
                                                                fit: BoxFit
                                                                    .fill),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 300,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: wallModels.isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${wallModels[index].image![2]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_12.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (wallModels[index].image!.length == 4)
                                    Container(
                                      width: 380,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),

                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: wallModels.isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${wallModels[index].image![0]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_2.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: wallModels.isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${wallModels[index].image![1]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_3.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: wallModels.isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${wallModels[index].image![2]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_4.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Color(0xffFFFFFF),
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: wallModels.isNotEmpty
                                                        ? ExtendedImage.network(
                                                            "https://elbrit.devcorn.live/uploads/${wallModels[index].image![3]}",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'images/img_5.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (wallModels[index].video?.length == 1)
                                    Stack(
                                      children: [
                                        Container(
                                          width: 380,
                                          child: FutureBuilder(
                                            future:
                                                _initializeVideoPlayerFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return AspectRatio(
                                                  aspectRatio: _controller
                                                      .value.aspectRatio,
                                                  child:
                                                      VideoPlayer(_controller),
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            top: 0,
                                            bottom: 10,
                                            child: FloatingActionButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_controller
                                                      .value.isPlaying) {
                                                    _controller.pause();
                                                  } else {
                                                    _controller.play();
                                                  }
                                                });
                                              },
                                            )),
                                      ],
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 8),
                                    child: Text(
                                      wallModels.isNotEmpty
                                          ? wallModels[index].details!
                                          : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. A tellus nulla viverra gravida tristique. Sed lobortis dui ullamcorper quisque proin in eget cursus.',
                                      textAlign: TextAlign.left,
                                      maxLines: 100,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1.1,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff262930),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 20,
                                    padding: const EdgeInsets.only(
                                        left: 12, bottom: 10),
                                    child: Text(
                                      wallModels.isEmpty
                                          ? wallModels[index].publishedAt!
                                          : '20 hours ago',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff8394AA),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: wallModels.length),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}






  // child: SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       const SizedBox(
          //         height: 15,
          //       ),
          //       const SizedBox(
          //         height: 15,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(
          //           left: 15,
          //           right: 15,
          //         ),
          //         child: Container(
          //           height: 130,
          //           width: 380,
          //           decoration: BoxDecoration(
          //             color: const Color(0xffFFFFFF),
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //           child: Padding(
          //             padding:
          //                 const EdgeInsets.only(left: 8, right: 8, top: 20),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   children: [
          //                     Stack(
          //                       children: [
          //                         Container(
          //                           height: 30,
          //                           width: 30,
          //                           child: Image.asset(
          //                             'images/Vector-11.png',
          //                             scale: .8,
          //                           ),
          //                         ),
          //                         const Positioned(
          //                           top: 8,
          //                           left: 6,
          //                           child: Center(
          //                             child: Text(
          //                               'EC',
          //                               style: TextStyle(
          //                                   color: Colors.white,
          //                                   fontWeight: FontWeight.bold),
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'Elbrit Central',
          //                       style: GoogleFonts.dmSans(
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w500,
          //                         color: const Color(0xff262930),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 20,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     const Icon(Icons.attachment_sharp),
          //                     const SizedBox(
          //                       width: 20,
          //                     ),
          //                     Text(
          //                       'new.pdf',
          //                       style: GoogleFonts.dmSans(
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.bold,
          //                         color: const Color(0xff191919),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 15,
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.only(
          //                     left: 12,
          //                   ),
          //                   child: Text(
          //                     '20 hours ago',
          //                     style: GoogleFonts.dmSans(
          //                       fontSize: 10,
          //                       fontWeight: FontWeight.w500,
          //                       color: const Color(0xff8394AA),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       )
          //     ],
          //   ),
          // ),