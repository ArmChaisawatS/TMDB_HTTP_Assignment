import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tmdb_http_assignment/models/detail_model.dart';
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
  DetailModel? detailModels;
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
    var getdate = detailModels?.releaseDate;
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.5,
                    image: NetworkImage(
                      detailModels?.backdropPath == null
                          ? url + detailModels!.posterPath.toString()
                          : url + detailModels!.backdropPath.toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
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
                    Center(
                      child: Text(
                        '${detailModels?.title} (${getdate!.year})',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Releasing On - ${getdate.day}/${getdate.month}/${getdate.year} (${detailModels!.originalLanguage})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        ' ${detailModels!.runtime} min',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(0),
                          child: CircularPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            backgroundColor: Colors.white,
                            center: Text(
                              '${(detailModels!.getVoteAverage() * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            radius: 24,
                            lineWidth: 3.0,
                            percent: detailModels!.getVoteAverage(),
                            progressColor: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'User',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              'Score',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${detailModels?.tagline}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      '${detailModels?.overview}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
