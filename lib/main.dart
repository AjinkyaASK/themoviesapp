import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviesapp/bloc/bloc_actors.dart';
import 'package:themoviesapp/bloc/bloc_moviesall.dart';
import 'package:themoviesapp/bloc/bloc_moviesnowplaying.dart';
import 'package:themoviesapp/bloc/bloc_moviestoprated.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/repo/repository.dart';
import 'package:themoviesapp/screens/moviePage.dart';
import 'package:themoviesapp/ui/homePageSliverHeader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Movies App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MovieResponse allMoviesData;

  bool isNowPlayingListLoading = false;
  List<Movie> searchedMovies = [];

  void initMoviesList() async {
    await blocMoviesNowPlaying.getMovies();
    await blocMoviesTopRated.getMovies();
    await blocMoviesAll.getMovies();
    allMoviesData = blocMoviesAll.DefaultResponse;
    searchedMovies = allMoviesData.movies;
    setState(() {});
  }

  ScrollController _nowPlayingScrollController = ScrollController();

  @override
  void initState() {
    initMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String searchText = '';
    bool isSearching = false;

    _nowPlayingScrollController.addListener(() {
      if (_nowPlayingScrollController.position.maxScrollExtent ==
          _nowPlayingScrollController.position.pixels) {
        print('Reched List End');
        if (!isNowPlayingListLoading) {
          isNowPlayingListLoading = !isNowPlayingListLoading;
        }
      }
    });

    return Scaffold(
      backgroundColor: Color(0xFF181822),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: HomePageSliverHeaderDelegate(),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Color(0xFF181822),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: 'Search movies here'),
                      onChanged: (text) {
                        searchText = text.toLowerCase();
                        setState(() {
                          searchedMovies =
                              allMoviesData.movies.where((element) {
                            var title = element.title.toLowerCase();
                            return title.contains(text);
                          }).toList();
                        });
                      },
                      onSubmitted: (text) {
                        isSearching = !isSearching;
                      },
                    ),
                  ),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: searchedMovies.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Text(searchedMovies[index].title),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Text(
                      'Now Playing',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.65),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: blocMoviesNowPlaying.subject.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      }
                      return Container(
                        height: 290,
                        child: ListView.builder(
                          controller: _nowPlayingScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.movies.length + 1,
                          itemBuilder: (context, index) {
                            if (index == snapshot.data.movies.length) {
                              return Container(
                                width: 120,
                                height: 290,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    bottom: 40, right: 20),
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
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MoviePage(
                                          index: index,
                                          moviesList: snapshot.data.movies,
                                        )));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 250,
                                    width: 190,
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.indigo.withOpacity(0.15),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF333388)
                                                .withOpacity(0.35),
                                            blurRadius: 40,
                                            offset: Offset(0, 12)),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      clipBehavior: Clip.hardEdge,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            snapshot.data.movies[index].poster,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width: 210,
                                    height: 30,
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Text(
                                      snapshot.data.movies[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.65),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 32, bottom: 18, left: 16, right: 16),
                  //   child: Text(
                  //     'Trending Actors',
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       color: Colors.white.withOpacity(0.65),
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //   ),
                  // ),
                  // StreamBuilder(
                  //   stream: blocActors.subject.stream,
                  //   builder: (context, snapshot) {
                  //     if (!snapshot.hasData) {
                  //       return Text('Loading...');
                  //     }
                  //     if (snapshot.data.error != null &&
                  //         snapshot.data.error.length > 0) {
                  //       return Text(snapshot.data.error);
                  //     }
                  //     return Container(
                  //       height: 120,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         physics: BouncingScrollPhysics(),
                  //         itemCount: snapshot.data.actors.length,
                  //         itemBuilder: (context, index) {
                  //           return Stack(
                  //             children: <Widget>[
                  //               Container(
                  //                 margin:
                  //                     const EdgeInsets.symmetric(horizontal: 6),
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.grey[900],
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   border: Border.all(
                  //                     width: 1,
                  //                     color: Colors.indigo.withOpacity(0.15),
                  //                   ),
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                         color: Color(0xFF333388)
                  //                             .withOpacity(0.25),
                  //                         blurRadius: 40,
                  //                         offset: Offset(0, 12)),
                  //                   ],
                  //                 ),
                  //                 child: ClipRRect(
                  //                   borderRadius: BorderRadius.circular(6),
                  //                   clipBehavior: Clip.hardEdge,
                  //                   child: Container(
                  //                     height: 120,
                  //                     width: 120,
                  //                     foregroundDecoration: BoxDecoration(
                  //                       gradient: LinearGradient(
                  //                           colors: [
                  //                             Colors.black.withOpacity(0),
                  //                             Colors.indigo[800]
                  //                           ],
                  //                           begin: Alignment.topRight,
                  //                           end: Alignment.bottomLeft),
                  //                     ),
                  //                     child: CachedNetworkImage(
                  //                       imageUrl:
                  //                           snapshot.data.actors[index].picture,
                  //                       fit: BoxFit.cover,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 left: 30,
                  //                 bottom: 10,
                  //                 child: Text(snapshot.data.actors[index].name),
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, bottom: 18, left: 16, right: 16),
                    child: Text(
                      'Top Rated Movies',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.65),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: blocMoviesTopRated.subject.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      }
                      if (snapshot.data.error != null &&
                          snapshot.data.error.length > 0) {
                        return Text(snapshot.data.error);
                      }
                      return Container(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.movies.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.indigo.withOpacity(0.15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF333388)
                                              .withOpacity(0.25),
                                          blurRadius: 40,
                                          offset: Offset(0, 12)),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    clipBehavior: Clip.hardEdge,
                                    child: Container(
                                      height: 160,
                                      width: 120,
                                      foregroundDecoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black.withOpacity(0),
                                              Colors.indigo[800]
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            snapshot.data.movies[index].poster,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  bottom: 16,
                                  right: 16,
                                  child: Text(
                                    snapshot.data.movies[index].title,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 42, bottom: 8, left: 16, right: 16),
                    child: Text(
                      'All Movies',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.65),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: blocMoviesAll.subject.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      }
                      if (snapshot.data.error != null &&
                          snapshot.data.error.length > 0) {
                        return Text(snapshot.data.error);
                      }
                      return Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.movies.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 200,
                                  //width: 190,
                                  margin: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF181822),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.indigo.withOpacity(0.15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF333388)
                                              .withOpacity(0.35),
                                          blurRadius: 40,
                                          offset: Offset(0, 12)),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          width: 120,
                                          height: 200,
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data.movies[index].poster,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 18),
                                      Container(
                                        child: Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 18),
                                              Flexible(
                                                child: Text(
                                                  snapshot
                                                      .data.movies[index].title,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white
                                                        .withOpacity(0.65),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                height: 2,
                                                width: 34,
                                                color: Colors.lightBlue[500],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: Colors.lightBlue,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: Colors.lightBlue,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: Colors.lightBlue,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: Colors.lightBlue,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: Colors.grey[300]
                                                        .withOpacity(0.8),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4),
                                                    child: Text(
                                                      '(${snapshot.data.movies[index].voteCount})',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                            .withOpacity(0.75),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 12),
                                                child: Text(
                                                  'Languages: NA}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white
                                                        .withOpacity(0.65),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8),
                                                child: Text(
                                                  'Release: NA}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white
                                                        .withOpacity(0.75),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
