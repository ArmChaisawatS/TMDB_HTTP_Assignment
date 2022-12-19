import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb_http_assignment/screen/nowplaying_screen.dart';
import 'package:tmdb_http_assignment/screen/popular_screen.dart';
import 'package:tmdb_http_assignment/screen/toprate_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            'assets/images/logo.svg',
            height: 15,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.timer_outlined,
                  color: Colors.blue,
                ),
                child: Text('nowplaying'),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.purple,
                ),
                child: Text('popular'),
              ),
              Tab(
                icon: Icon(
                  Icons.star_rate,
                  color: Colors.amber,
                ),
                child: Text('toprage'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NowPlayingScreen(),
            PopularScreen(),
            TopRateScreen(),
          ],
        ),
      ),
    );
  }
}
