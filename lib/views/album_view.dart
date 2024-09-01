import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_desktop/cubit/song_cubit/song_cubit.dart';
import 'package:musix_desktop/cubit/song_cubit/song_states.dart';
import 'package:musix_desktop/data/model/song_model.dart';
import 'package:musix_desktop/services/util.dart';
import 'package:musix_desktop/widgets/album_card.dart';

class AlbumView extends StatefulWidget {
  final SongModel song;

  const AlbumView({super.key, required this.song});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late ScrollController scrollController;

  double imageSize = 0;

  double initialSize = 240;

  double containerHeight = 500;

  double containerinitalHeight = 500;

  double imageOpacity = 1;

  bool showTopBar = false;

  @override
  void initState() {
    imageSize = initialSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialSize - scrollController.offset;
        if (imageSize < 0) {
          imageSize = 0;
        }
        containerHeight = containerinitalHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialSize;
        if (scrollController.offset > 224) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        print(scrollController.offset);
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardSize = MediaQuery.of(context).size.width / 2 - 32;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: containerHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            //decoration color
            color: hexToColor(widget.song.hex_code),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: imageOpacity.clamp(0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          offset: const Offset(0, 20),
                          blurRadius: 32,
                          spreadRadius: 16,
                        )
                      ],
                    ),
                    child: Image(
                      image: NetworkImage(widget.song.thumbnail_url),
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          SizedBox(height: initialSize + 32),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //description
                                Text(
                                  widget.song.title,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                const Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/logo.png'),
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 8),
                                    Text("Spotify")
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "1,888,132 likes 5h 3m",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 16),
                                const Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.favorite),
                                        SizedBox(width: 16),
                                        Icon(Icons.more_horiz),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.black,
                    child: ListTile(
                      title: Text(widget.song.title),
                      subtitle: Text(widget.song.artist),
                    ),
                    // child: BlocBuilder<SongCubit, SongStates>(
                    //   builder: (context, state) {
                    //     return ListView.builder(
                    //                       itemCount: state.songs.length,
                    //                       itemBuilder: (BuildContext context, int index) {
                    //                         final data = state.songs[index];
                    //                         return ;
                    //                       },
                    //                     );
                    //   },
                    // ),,
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Text(
                    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
                    //     const SizedBox(height: 32),
                    //     Text(
                    //       "You might also like",
                    //       style: Theme.of(context).textTheme.titleLarge,
                    //     ),

                    //     //you may also like
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 5),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           AlbumCard(
                    //             size: cardSize,
                    //             label: "Get Turnt",
                    //             image: AssetImage("assets/album3.jpg"),
                    //           ),
                    //           AlbumCard(
                    //             size: cardSize,
                    //             label: "Get Turnt",
                    //             image: AssetImage("assets/album5.jpg"),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 5),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           AlbumCard(
                    //             size: cardSize,
                    //             label: "Get Turnt",
                    //             image: AssetImage("assets/album6.jpg"),
                    //           ),
                    //           AlbumCard(
                    //             size: cardSize,
                    //             label: "Get Turnt",
                    //             image: AssetImage("assets/album9.jpg"),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 5),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           AlbumCard(
                    //             size: cardSize,
                    //             label: "Get Turnt",
                    //             image: AssetImage("assets/album10.jpg"),
                    //           ),
                    //           AlbumCard(
                    //             size: cardSize,
                    //             label: "Get Turnt",
                    //             image: AssetImage("assets/album4.jpg"),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  )
                ],
              ),
            ),
          ),
          // App bar
          Positioned(
              child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: showTopBar
                ? hexToColor(widget.song.hex_code).withOpacity(1)
                : const Color(0xFFC61855).withOpacity(0),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: SafeArea(
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 38,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: showTopBar ? 1 : 0,
                      child: Text(
                        widget.song.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom:
                          80 - containerHeight.clamp(120.0, double.infinity),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff14D860),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 38,
                            ),
                          ),
                          // Container(
                          //   width: 24,
                          //   height: 24,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.white,
                          //   ),
                          //   child: Icon(
                          //     Icons.shuffle,
                          //     color: Colors.black,
                          //     size: 14,
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
