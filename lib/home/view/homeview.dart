import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                return TrackCard(track: state.tracks.trackList![index].track!);
              },
            );
          } else {
            return const Center(child: Text("Error"));
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
