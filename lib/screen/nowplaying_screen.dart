import 'package:flutter/material.dart';
import 'package:tmdb_http_assignment/models/movie_model.dart';
import 'package:tmdb_http_assignment/service/remote_service.dart';
import 'package:tmdb_http_assignment/widgets/gridview_widget.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  MoviesModel? moviesModel;
  bool isLoading = false;
  String keyword = "now_playing";

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isLoading = true;
    moviesModel = await RemoteService().getMovies(keyword);
    if (moviesModel != null) {
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridviewWidget(
              model: moviesModel,
            ),
    );
  }
}
