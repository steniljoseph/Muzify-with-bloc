// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/database/dbsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:marquee/marquee.dart';
import '../logic/bloc/icon_bloc/icon_bloc_bloc.dart';
import 'addtoplaylist.dart';

class MusicPlayerScreen extends StatelessWidget {
  int index;
  List<Audio> fullSongs = [];
  MusicPlayerScreen({Key? key, required this.index, required this.fullSongs})
      : super(key: key);

//   @override
//   MusicPlayerScreenState createState() => MusicPlayerScreenState();
// }

// class MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool isPlaying = false;
  bool isLooping = false;
  bool isShuffle = false;

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  final box = MusicBox.getInstance();
  List<LocalSongs> dbSongs = [];
  List<dynamic>? likedSongs = [];
 
  // @override
  // void initState() {
  //   super.initState();
  //   dbSongs = box.get("musics") as List<LocalSongs>;
  // }
  LocalSongs databaseSongs(List<LocalSongs> songs, String id) {
    return songs.firstWhere(
      (element) => element.id.toString().contains(id),
    );
  }

  @override
  Widget build(BuildContext context) {
    dbSongs = box.get("musics") as List<LocalSongs>;
    // LocalSongs? currentSong;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(FontAwesomeIcons.chevronDown),
          ),
          title: const Text(
            'Now Playing',
          ),
          centerTitle: true,
          // actions: [
          //   PopupMenuButton(
          //     itemBuilder: (BuildContext bc) => [
          //       const PopupMenuItem(
          //         child: Text(
          //           "Add to Playlist",
          //           style: TextStyle(fontFamily: 'Poppins'),
          //         ),
          //         value: "1",
          //       ),
          //     ],
          //     onSelected: (value) async {
          //       if (value == "1") {
          //         showModalBottomSheet(
          //           context: context,
          //           builder: (context) => AddtoPlayList(song: currentSong!),
          //         );
          //       }
          //     },
          //   )
          // ],
        ),
        body: player.builderCurrent(
          builder: (context, Playing? playing) {
            final myAudio = find(fullSongs, playing!.audio.assetAudioPath);

            final currentSong = dbSongs.firstWhere((element) =>
                element.id.toString() == myAudio.metas.id.toString());

            likedSongs = box.get("favourites");

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 50,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x46000000),
                          offset: Offset(20, 20),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: Color(0x11000000),
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: QueryArtworkWidget(
                          size: 2000,
                          artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                          artworkFit: BoxFit.cover,
                          nullArtworkWidget:
                              Image.asset('assets/images/logodefault.jpg'),
                          id: int.parse(myAudio.metas.id!),
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: Marquee(
                      text: myAudio.metas.title!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Poppins',
                      ),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 50.0,
                      pauseAfterRound: const Duration(seconds: 1),
                      startPadding: 5.0,
                      accelerationDuration: const Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: const Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                  Text(
                    myAudio.metas.artist!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: seekBar(context),
                  ),
                  BlocBuilder<IconBlocBloc, IconBlocState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          !isShuffle
                              ? IconButton(
                                  onPressed: () {
                                    isShuffle = true;
                                    player.toggleShuffle();
                                    context.read<IconBlocBloc>().add(
                                          const IconChangeEvent(
                                            iconData: Icons.shuffle,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.shuffle),
                                )
                              : IconButton(
                                  onPressed: () {
                                    isShuffle = false;
                                    player.setLoopMode(LoopMode.playlist);
                                    context.read<IconBlocBloc>().add(
                                          const IconChangeEvent(
                                            iconData: Icons.cached,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.cached),
                                ),
                          likedSongs!
                                  .where((element) =>
                                      element.id.toString() ==
                                      currentSong.id.toString())
                                  .isEmpty
                              ? IconButton(
                                  onPressed: () async {
                                    likedSongs?.add(currentSong);
                                    box.put("favourites", likedSongs!);
                                    likedSongs = box.get("favourites");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          myAudio.metas.title! +
                                              " Added to Favourites",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins'),
                                        ),
                                      ),
                                    );
                                    context.read<IconBlocBloc>().add(
                                          const IconChangeEvent(
                                            iconData: Icons.favorite_border,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.favorite_border),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    likedSongs?.removeWhere((elemet) =>
                                        elemet.id.toString() ==
                                        currentSong.id.toString());
                                    box.put("favourites", likedSongs!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                          myAudio.metas.title! +
                                              " Removed from Favourites",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins'),
                                        ),
                                      ),
                                    );
                                    context.read<IconBlocBloc>().add(
                                          const IconChangeEvent(
                                            iconData: Icons.favorite,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.favorite),
                                ),
                          !isLooping
                              ? IconButton(
                                  onPressed: () {
                                    isLooping = true;
                                    player.setLoopMode(LoopMode.single);
                                    context.read<IconBlocBloc>().add(
                                          const IconChangeEvent(
                                            iconData: Icons.repeat,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.repeat),
                                )
                              : IconButton(
                                  onPressed: () {
                                    isLooping = false;
                                    player.setLoopMode(LoopMode.playlist);
                                    context.read<IconBlocBloc>().add(
                                          const IconChangeEvent(
                                            iconData: Icons.repeat_one,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.repeat_one),
                                ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          player.previous();
                        },
                        icon: const Icon(FontAwesomeIcons.stepBackward),
                      ),
                      PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) {
                          return IconButton(
                            iconSize: 50,
                            onPressed: () async {
                              await player.playOrPause();
                            },
                            icon: Icon(
                              isPlaying
                                  ? FontAwesomeIcons.pause
                                  : FontAwesomeIcons.play,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          player.next();
                        },
                        icon: const Icon(FontAwesomeIcons.stepForward),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget seekBar(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration currentPos = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ProgressBar(
            progress: currentPos,
            total: total,
            // progressBarColor: Colors.grey,
            baseBarColor: Colors.grey,
            // thumbColor: Colors.grey,
            timeLabelTextStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.grey,
            ),
            onSeek: (to) {
              player.seek(to);
            },
          ),
        );
      },
    );
  }
}
