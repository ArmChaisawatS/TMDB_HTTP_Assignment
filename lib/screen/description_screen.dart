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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    image: DecorationImage(
                        opacity: 0.5,
                        image: NetworkImage(
                          detailModels?.backdropPath == null
                              ? url + detailModels!.posterPath.toString()
                              : url + detailModels!.backdropPath.toString(),
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                        child: ModifiedText(
                          text: '${detailModels?.title} (${getdate!.year})',
                          color: Colors.white,
                          size: 28,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: ModifiedText(
                          text:
                              'Releasing On - ${getdate.day}/${getdate.month}/${getdate.year} (${detailModels!.originalLanguage})',
                          color: Colors.white,
                          size: 18,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Center(
                        child: ModifiedText(
                          text: ' ${detailModels!.runtime} min',
                          color: Colors.white,
                          size: 18,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
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
                              center: ModifiedText(
                                text: '${(getvote! * 10).toStringAsFixed(0)}%',
                                color: Colors.white,
                                size: 18,
                                textAlign: TextAlign.start,
                              ),
                              radius: 24,
                              lineWidth: 3.0,
                              percent: getvote / 10,
                              progressColor: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              ModifiedText(
                                  text: 'User',
                                  color: Colors.white,
                                  size: 18,
                                  textAlign: TextAlign.start),
                              ModifiedText(
                                  text: 'Score',
                                  color: Colors.white,
                                  size: 18,
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ModifiedText(
                        text: '${detailModels?.tagline}',
                        color: Colors.grey,
                        size: 20,
                        textAlign: TextAlign.start,
                      ),
                      const ModifiedText(
                        text: 'Overview',
                        color: Colors.white,
                        size: 28,
                        textAlign: TextAlign.start,
                      ),
                      ModifiedText(
                        text: '${detailModels?.overview}',
                        color: Colors.white,
                        size: 20,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
