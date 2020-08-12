import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviesapp/bloc/bloc_moviesnowplaying.dart';
import 'package:themoviesapp/screens/movie_page.dart';

double homeHeadershrinkFactor = 1;
double homeHeadershrinkFactorEnhanced = 1;

class HomePageSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback callback;

  HomePageSliverHeaderDelegate({this.callback});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkFactor = (maxExtent - shrinkOffset) /
        maxExtent; //The shrinkFactor is calculated as how much scrollable header area is remaining
    double shrinkFactorEnhanced = pow(shrinkFactor,
        6); //Enhances the shrinkOffset by making it reach 0, 5 times faster
    homeHeadershrinkFactor = shrinkFactor;
    homeHeadershrinkFactorEnhanced = shrinkFactorEnhanced;
    return HomePageHeaderBody();
  }

  @override
  double get maxExtent => 340;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class HomePageHeaderBody extends StatefulWidget {
  @override
  _HomePageHeaderBodyState createState() => _HomePageHeaderBodyState();
}

class _HomePageHeaderBodyState extends State<HomePageHeaderBody> {
  final nowPlayingPageController = PageController(viewportFraction: 1);
  int nowPlayingMoviesCount = 0;
  int currentNowPlayingPageIndex = 0;

  _HomePageHeaderBodyState();

  void initNowPlayingMovies() async {
    await blocMoviesNowPlaying.getMovies();
  }

  void autoSlideNowPlayingPages() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (nowPlayingMoviesCount > 1) {
        if (currentNowPlayingPageIndex < nowPlayingMoviesCount) {
          currentNowPlayingPageIndex++;
        } else {
          currentNowPlayingPageIndex = 0;
        }

        nowPlayingPageController.animateToPage(
          currentNowPlayingPageIndex,
          duration: Duration(milliseconds: 750),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void initState() {
    initNowPlayingMovies();
    autoSlideNowPlayingPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Home Header Rebuilt: $homeHeadershrinkFactorEnhanced');
    return Container(
      color: Color(0xFF181822),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Opacity(
            opacity: homeHeadershrinkFactorEnhanced,
            child: StreamBuilder(
              stream: blocMoviesNowPlaying.subject.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading...');
                }
                nowPlayingMoviesCount = snapshot.data.movies.length;
                return Stack(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      height: 340,
                      child: PageView.builder(
                        controller: nowPlayingPageController,
                        pageSnapping: false,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.movies.length,
                        itemBuilder: (context, index) {
                          if (index == snapshot.data.movies.length) {
                            return Container(
                              width: 120,
                              height: 340,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(bottom: 40, right: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  CupertinoActivityIndicator(radius: 15),
                                  // SizedBox(height: 20),
                                  // Text(
                                  //   'Wait',
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //     color: Colors.white.withOpacity(0.5),
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          }
                          // print(
                          //     snapshot.data.movies[index].backPoster);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MoviePage(
                                        movie: snapshot.data.movies[index],
                                      )));
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl:
                                      snapshot.data.movies[index].backPoster,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: Colors.indigo[900],
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.indigo[800],
                                        Colors.indigo[900].withOpacity(0.7),
                                        Color(0xFF181822),
                                      ],
                                      stops: [0, 0.25, homeHeadershrinkFactor],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    // border: Border(
                                    //   bottom: BorderSide(
                                    //       color: Colors.indigo.withOpacity(0.35), width: 0.5),
                                    // ),
                                  ),
                                ),
                                Positioned(
                                  left: 24,
                                  right: 32,
                                  bottom: 48,
                                  child: Row(
                                    children: <Widget>[
                                      // Container(
                                      //   height: 100,
                                      //   width: 100,
                                      //   child: CachedNetworkImage(
                                      //     imageUrl:
                                      //         snapshot.data.movies[index].poster,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                      // SizedBox(width: 24),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.movies[index].title,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.star,
                                                  size: 14,
                                                  color: Colors.amber[500],
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 14,
                                                  color: Colors.amber[500],
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 14,
                                                  color: Colors.amber[500],
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 14,
                                                  color: Colors.amber[500],
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 14,
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Released: ' +
                                                  snapshot.data.movies[index]
                                                      .releaseDate,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white
                                                    .withOpacity(0.65),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SmoothPageIndicator(
                        controller: nowPlayingPageController,
                        count: snapshot.data.movies.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 4,
                          dotWidth: 4,
                          dotColor: Colors.white.withOpacity(0.2),
                          activeDotColor: Colors.white.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 45,
                ),
                RichText(
                  text: TextSpan(
                      text: 'TheMovies',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 4,
                              offset: Offset(1, 1))
                        ],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'App',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.lightBlue[300],
                            shadows: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 4,
                                  offset: Offset(1, 1))
                            ],
                          ),
                        )
                      ]),
                ),
                Icon(
                  Icons.more_horiz,
                  size: 24,
                  color: Colors.white.withOpacity(0.75),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
