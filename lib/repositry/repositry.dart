import 'package:dartz/dartz.dart';
import 'package:flutter_task/service/service.dart';

import '../data/music.dart';
import '../data/track.dart';

class Repositry {
  final ServiceClass _serviceClass;

  Repositry(this._serviceClass);

  Future<Either<String, TrackList>> getTracks() async {
    try {
      final tracks = await _serviceClass.getTracks();
      return Right(tracks);
    } catch (e) {
      print(e);
      return const Left("Something went wrong");
    }
  }

  Future<Either<String, Track>> getParticularTrack(String trackId) async {
    try {
      final Track track = await _serviceClass.getParticularTrack(trackId);
      return Right(track);
    } catch (e) {
      return const Left("Something went wrong");
    }
  }

  Future<Either<String, Lyrics>> getLyricsOfTrack(String trackId) async {
    try {
      final Lyrics lyrics = await _serviceClass.getLyricsOfTrack(trackId);
      return Right(lyrics);
    } catch (e) {
      return const Left("Something went wrong");
    }
  }
}
