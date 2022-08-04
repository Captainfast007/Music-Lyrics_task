import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/DetailsPage/view/detailsView.dart';
import 'package:flutter_task/data/track.dart';
import 'package:flutter_task/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = ref.read(homeBlocProvider);
    _homeBloc.add(HomeInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return ListView.builder(
              itemCount: state.tracks.trackList!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child:
                      TrackCard(track: state.tracks.trackList![index].track!),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => DetailsPage(
                            state.tracks.trackList![index].track?.trackId,
                            state.tracks.trackList![index].track?.trackName,
                            state.tracks.trackList![index].track?.albumName,
                            state.tracks.trackList![index].track?.trackRating,
                            state.tracks.trackList![index].track?.artistName),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
                child: Text(
              "Error",
              style: TextStyle(fontSize: 50.0),
            ));
          }
        },
      ),
    );
  }
}

class TrackCard extends StatelessWidget {
  const TrackCard({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(track.trackName ?? "Null"),
    );
  }
}
