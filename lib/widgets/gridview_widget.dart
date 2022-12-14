import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tmdb_http_assignment/screen/description_screen.dart';

class GridviewWidget extends StatelessWidget {
  final dynamic model;
  const GridviewWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    String url = 'https://image.tmdb.org/t/p/w500';
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.57,
      ),
      itemCount: model?.results?.length ?? 0,
      itemBuilder: ((context, index) {
        var data = model?.results?[index];
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
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 290,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                      ),
                      child: CircularPercentIndicator(
                        backgroundColor: Colors.white,
                        animation: true,
                        animationDuration: 1000,
                        progressColor: Colors.green,
                        center: Text(
                          '${(data.getVoteAverage() * 100).toStringAsFixed(0)} %',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        radius: 16,
                        lineWidth: 2.0,
                        percent: data.getVoteAverage(),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      data.title.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${data.releaseDate!.day}/${data.releaseDate!.month}/${data.releaseDate!.year}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
