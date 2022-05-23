import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/database/dbsongs.dart';
import 'package:music/logic/bloc/icon_bloc/icon_bloc_bloc.dart';
import 'package:music/screens/splash.dart';
import 'package:music/themeprovider.dart';
import 'logic/bloc/favourites/favourites_bloc.dart';
import 'logic/bloc/search/search_bloc_bloc.dart';
import 'logic/cubit/bottom_cubit/bottomnav_cubit.dart';
import 'logic/cubit/switchstate/switchstate_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalSongsAdapter());
  await Hive.openBox<List>(boxname);
  final box = MusicBox.getInstance();
  List<dynamic> favKeys = box.keys.toList();
  if (!favKeys.contains("favourites")) {
    List<dynamic> likedSongs = [];
    await box.put("favourites", likedSongs);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomnavCubit(),
        ),
        BlocProvider(
          create: (context) => SwitchstateCubit(),
        ),
        BlocProvider(
          create: (context) => FavouritesBloc(),
        ),
        BlocProvider(
          create: (context) => IconBlocBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBlocBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        title: 'Muzify',
        home: const SplashScreen(),
      ),
    );
  }
}
