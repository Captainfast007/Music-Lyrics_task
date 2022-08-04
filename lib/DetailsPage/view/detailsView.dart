import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/data/music.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider.dart';
import '../../repositry/repositry.dart';
import '../../service/service.dart';
import '../bloc/details_bloc.dart';

class DetailsPage extends StatefulHookConsumerWidget {
  final int? trackId;
  final String? trackName;
  final String? albumName;
  final int? rating;
  final String? artistName;

  const DetailsPage(this.trackId, this.trackName, this.albumName, this.rating,
      this.artistName);

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  late DetailsBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = DetailsBloc(
      Repositry(
        ServiceClass(
          ref.read(dioProvider),
        ),
      ),
    );
    if (widget.trackId != null) _homeBloc.add(PageStarted(widget.trackId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailsLoaded) {
            return mainBody(state.lyrics, widget.trackName, widget.artistName,
                widget.albumName, widget.rating);
          } else {
            return const Center(child: Text("Error"));
          }
        },
      ),
    );
  }

  Widget mainBody(Lyrics lyrics, String? trackName, String? artistName,
      String? albumName, int? rating) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 8.0,
          right: 8.0,
        ),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Name",
              style: TextStyle(fontSize: 20.0),
            ),
            // const SizedBox(
            //   height: 8.0,
            //   ),
            Text(trackName.toString()),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Artist Name",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(artistName.toString()),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Album Name",
              style: TextStyle(fontSize: 20.0),
            ),

            Text(albumName.toString()),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Rating",
              style: TextStyle(fontSize: 20.0),
            ),

            Text("$rating"),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Lyrics",
              style: TextStyle(fontSize: 20.0),
            ),

            Text(lyrics.lyricsBody.toString())
          ],
        )),
      ),
    );
  }
}
