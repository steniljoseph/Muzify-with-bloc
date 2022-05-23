// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../classes/openaudio.dart';
import '../logic/bloc/search/search_bloc_bloc.dart';

class SearchScreen extends StatelessWidget {
  List<Audio> fullSongs = [];
  SearchScreen({Key? key, required this.fullSongs}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
  // final box = MusicBox.getInstance();
  String search = "";

  // List<LocalSongs> dbSongs = [];
  // List<Audio> allSongs = [];

  // searchSongs() {
  //   dbSongs = box.get("musics") as List<LocalSongs>;
  //   for (var element in dbSongs) {
  //     allSongs.add(
  //       Audio.file(
  //         element.uri.toString(),
  //         metas: Metas(
  //           title: element.title,
  //           id: element.id.toString(),
  //           artist: element.artist,
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Search',
          ),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              // const SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Search',
              //       style: GoogleFonts.poppins(
              //           fontSize: 30, fontWeight: FontWeight.w600),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .9,
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 14, right: 10, left: 10),
                    suffixIcon: Icon(FontAwesomeIcons.search),
                    hintText: ' Search a song',
                    filled: true,
                    hintStyle:
                        TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                  ),
                  onChanged: (value) {
                    search = value.trim();
                    context
                        .read<SearchBlocBloc>()
                        .add(SerachInputEvent(search: value));
                  },
                ),
              ),
              BlocBuilder<SearchBlocBloc, SearchBlocState>(
                builder: (context, state) {
                  List<Audio> searchResult = state.props as List<Audio>;
                  return search.isNotEmpty
                      ? searchResult.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: searchResult.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      OpenPlayer(
                                              fullSongs: searchResult,
                                              index: index)
                                          .openAssetPlayer(
                                        index: index,
                                        songs: searchResult,
                                      );
                                    },
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: QueryArtworkWidget(
                                          id: int.parse(
                                              searchResult[index].metas.id!),
                                          type: ArtworkType.AUDIO,
                                          artworkBorder:
                                              BorderRadius.circular(15),
                                          artworkFit: BoxFit.cover,
                                          nullArtworkWidget: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/logodefault.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        searchResult[index].metas.title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      subtitle: Text(
                                        searchResult[index].metas.artist!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                "No Result Found",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                ),
                              ),
                            )
                      : const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
