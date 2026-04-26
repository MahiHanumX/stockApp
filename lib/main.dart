import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/watchlist/data/watchlist_repository.dart';
import 'features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'features/watchlist/presentation/bloc/watchlist_event.dart';
import 'features/watchlist/presentation/page/watchlist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) =>
            WatchlistBloc(WatchlistRepository())..add(LoadWatchlist()),
        child: const WatchlistPage(),
      ),
    );

  }
}
