import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../bloc/details_bloc.dart';

class DetailsPage extends StatefulHookConsumerWidget {
  final String trackId;
  const DetailsPage({Key? key, required this.trackId}) : super(key: key);

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  late DetailsBloc _homeBloc;
  @override
  void initState() {
    _homeBloc.add(DetailsInital());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailsBloc, DetailsState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailsLoaded) {
            return Container();
          } else {
            return const Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}


