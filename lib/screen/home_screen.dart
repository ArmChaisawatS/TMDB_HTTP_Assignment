import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tmdb_http_assignment/models/tmdb_model.dart';
import 'package:tmdb_http_assignment/screen/description_screen.dart';
import 'package:tmdb_http_assignment/service/remote_service.dart';
import '../models/text_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TmdbModels? tmdbModels;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    tmdbModels = await RemoteService().getmovies();
    if (tmdbModels != null) {
      setState(
        () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String url = 'https://image.tmdb.org/t/p/w500';
    return Scaffold(
      appBar: AppBar(
        title: const Text('tmdb'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.56),
        itemCount: tmdbModels?.results?.length ?? 0,
        itemBuilder: ((context, index) {
          var data = tmdbModels?.results?[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescriptionScreen(
                    id: data.id!.toInt(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 280,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: NetworkImage(
                              url + data!.posterPath.toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: Container(
                        height: 35,
                        width: 35,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black),
                        child: CircularPercentIndicator(
                          backgroundColor: Colors.white,
                          animation: true,
                          animationDuration: 1000,
                          progressColor: Colors.green,
                          center: ModifiedText(
                            text:
                                '${(data.voteAverage!.toDouble() * 10).toStringAsFixed(0)} %',
                            color: Colors.white,
                            size: 12,
                            textAlign: TextAlign.center,
                          ),
                          radius: 16,
                          lineWidth: 2.0,
                          percent: data.voteAverage!.toInt() / 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Column(
                  children: [
                    ModifiedText(
                      text: data.title.toString(),
                      color: Colors.black,
                      size: 16,
                      textAlign: TextAlign.center,
                    ),
                    ModifiedText(
                      text: "(${data.releaseDate!.year.toString()})",
                      color: Colors.grey,
                      size: 14,
                      textAlign: TextAlign.center,
                    ),
                    ModifiedText(
                      text:
                          '${data.releaseDate!.day}/${data.releaseDate!.month}/${data.releaseDate!.year}',
                      color: Colors.grey,
                      size: 14,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
