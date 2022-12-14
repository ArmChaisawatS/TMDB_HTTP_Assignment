import 'package:flutter/material.dart';
import 'package:tmdb_http_assignment/models/popular_model.dart';
import 'package:tmdb_http_assignment/service/remote_service.dart';
import 'package:tmdb_http_assignment/widgets/gridview_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  PopularModel? popularModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isLoading = true;
    popularModel = await RemoteService().getPopularMovies();
    if (popularModel != null) {
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
              model: popularModel,
            ),
    );
  }
}
