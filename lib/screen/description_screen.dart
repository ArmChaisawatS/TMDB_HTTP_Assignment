import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tmdb_http_assignment/models/detail_model.dart';
import 'package:tmdb_http_assignment/models/text_model.dart';
import 'package:tmdb_http_assignment/service/remote_service.dart';

class DescriptionScreen extends StatefulWidget {
  final int id;

  const DescriptionScreen({
    super.key,
    required this.id,
  });

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  DetailModels? detailModels;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isLoading = true;
    detailModels = await RemoteService().getDetails(widget.id);
    if (detailModels != null) {
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String url = 'https://image.tmdb.org/t/p/w500';
    var getvote = detailModels?.voteAverage;
    var getdate = detailModels?.releaseDate;
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(
              child: Text('Loading'),
            )
          : ListView(
              children: [
                Container(
                  height: 1000,
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.network(
                            detailModels?.backdropPath == null
                                ? url + detailModels!.posterPath.toString()
                                : url + detailModels!.backdropPath.toString(),
                            fit: BoxFit.fitHeight,
                            height: 650,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 90,
                        top: 30,
                        child: Container(
                          padding: EdgeInsets.zero,
                          height: 350,
                          width: 235,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(
                                url + detailModels!.posterPath.toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 460,
                        left: 20,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(0),
                          child: CircularPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            backgroundColor: Colors.white,
                            center: ModifiedText(
                              text: '${(getvote! * 10).toStringAsFixed(0)}%',
                              color: Colors.white,
                              size: 16,
                              textAlign: TextAlign.start,
                            ),
                            radius: 18,
                            lineWidth: 2.0,
                            percent: getvote / 10,
                            progressColor: Colors.green,
                          ),
                        ),
                      ),
                      Positioned(
                        width: 400,
                        top: 390,
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          child: ModifiedText(
                            text: detailModels?.title ?? 'NOT Loaded',
                            color: Colors.white,
                            size: 22,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 420,
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          child: ModifiedText(
                            text:
                                'Releasing On - ${getdate!.day}/${getdate.month}/${getdate.year}',
                            color: Colors.white,
                            size: 16,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 12,
                        top: 500,
                        child: ModifiedText(
                          text: 'Overview',
                          color: Colors.white,
                          size: 24,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Positioned(
                        top: 530,
                        child: Container(
                          width: 400,
                          padding: const EdgeInsets.all(12),
                          child: ModifiedText(
                            text: '${detailModels?.overview}',
                            color: Colors.white,
                            size: 18,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
