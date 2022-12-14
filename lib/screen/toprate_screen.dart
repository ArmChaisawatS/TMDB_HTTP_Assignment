import 'package:flutter/material.dart';
import 'package:tmdb_http_assignment/models/toprate_model.dart';
import 'package:tmdb_http_assignment/service/remote_service.dart';
import 'package:tmdb_http_assignment/widgets/gridview_widget.dart';

class TopRateScreen extends StatefulWidget {
  const TopRateScreen({super.key});

  @override
  State<TopRateScreen> createState() => _TopRateScreenState();
}

class _TopRateScreenState extends State<TopRateScreen> {
  TopRateModel? topRateModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isLoading = true;
    topRateModel = await RemoteService().getTopRateMovies();
    if (topRateModel != null) {
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
              model: topRateModel,
            ),
    );
  }
}
