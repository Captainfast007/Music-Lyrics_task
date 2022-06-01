import 'package:dio/dio.dart';
import 'package:flutter_task/data/music.dart';

import '../data/track.dart';

class ServiceClass {
  final Dio _dio;

  ServiceClass(this._dio);
  static const String _baseUrl = 'https://api.musixmatch.com/ws/1.1';
  static const String _apiKey = '2d782bc7a52a41ba2fc1ef05b9cf40d7';

  Future<TrackList> getTracks() async {
    const String url = "$_baseUrl/chart.tracks.get?apikey=$_apiKey";
    final response = await _dio.get(url);
    return TrackList.fromJson(response.data['message']['body']);
  }

  Future<Track> getParticularTrack(String trackId) async {
    final String url = "$_baseUrl/track.get?track_id=$trackId&apikey=$_apiKey";
    final Response response = await _dio.get(url);
    return Track.fromJson(response.data['message']['body']);
  }

  Future<Lyrics> getLyricsOfTrack(String trackId) async {
    final String url =
        "$_baseUrl/track.lyrics.get?track_id=$trackId&apikey=$_apiKey";
    final Response response = await _dio.get(url);
    return Lyrics.fromJson(response.data['message']['body']['lyrics']);
  }
}
