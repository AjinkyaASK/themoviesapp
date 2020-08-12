import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviesapp/bloc/bloc_actors.dart';
import 'package:themoviesapp/bloc/bloc_moviesall.dart';
import 'package:themoviesapp/bloc/bloc_moviestoprated.dart';
import 'package:themoviesapp/bloc/searchProvider.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/screens/moviePage.dart';
import 'package:themoviesapp/ui/customDeviderWidget.dart';
import 'package:themoviesapp/ui/homePageSliverHeader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import 'package:themoviesapp/bloc/bloc_moviesearch.dart';
import 'package:themoviesapp/ui/searchResultWidgets.dart';
import 'package:themoviesapp/utils/values.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieResponse allMoviesData;
  int nowPlayingMoviesCount = 0;
  int currentNowPlayingPageIndex = 0;

  bool isTopMoviesListLoading = false;
  List<Movie> topRatedMovies = [];

  ScrollController _topMoviesScrollController = ScrollController();
  final nowPlayingPageController = PageController(viewportFraction: 0.9);

  String searchText = '';

  void initMoviesList() async {
    //await blocMoviesNowPlaying.getMovies();
    //await blocMoviesTopRated.getMovies();
    await blocActors.getActors();
    await blocMoviesAll.getMovies();

    await blocMoviesTopRated.getMoviesList().then((response) {
      setState(() {
        topRatedMovies = response.movies;
      });
    });
  }

  @override
  void initState() {
    initMoviesList();
    _topMoviesScrollController.addListener(() async {
      if (_topMoviesScrollController.position.maxScrollExtent ==
              _topMoviesScrollController.position.pixels &&
          !isTopMoviesListLoading) {
        setState(() {
          isTopMoviesListLoading = true;
        });
        print('List End: Loading more toprated movies');
        //await blocMoviesTopRated.getMovies();
        await blocMoviesTopRated.getMoviesList().then((response) {
          topRatedMovies.addAll(response.movies);
        });

        setState(() {
          // _topMoviesScrollController.animateTo(0,
          //     duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          isTopMoviesListLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _topMoviesScrollController.dispose();
    nowPlayingPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181822),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: HomePageSliverHeaderDelegate(callback: () {
                  setState(() {
                    isSearching = false;
                  });
                }),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFF181822),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 12, bottom: 16, left: 16, right: 16),
                      //   child: Text(
                      //     'Now Playing',
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //       color: Colors.white.withOpacity(0.65),
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32, bottom: 18, left: 16, right: 16),
                        child: Text(
                          'Trending Actors',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: blocActors.subject.stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('Loading...');
                          }
                          if (snapshot.data.error != null &&
                              snapshot.data.error.length > 0) {
                            return Text(snapshot.data.error);
                          }
                          return Container(
                            height: 100,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.actors.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 80,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          color: Colors.indigo[900]
                                              .withOpacity(0.5),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data.actors[index].picture,
                                            placeholder: (context, url) =>
                                                Container(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, child) =>
                                                    Container(
                                              color: Colors.grey[800],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        snapshot.data.actors[index].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.75),
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
                      CustomDeviderLight(),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18, left: 16, right: 16),
                        child: Text(
                          'Top Rated Movies',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 160,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 12),
                          controller: _topMoviesScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: !isTopMoviesListLoading
                              ? topRatedMovies.length + 1
                              : topRatedMovies
                                  .length, //+1 for the CupertinoActivityIndicator
                          itemBuilder: (context, index) {
                            if (!isTopMoviesListLoading &&
                                index == topRatedMovies.length) {
                              return Container(
                                width: 120,
                                height: 290,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CupertinoActivityIndicator(radius: 15),
                                    // SizedBox(height: 20),
                                    // Text(
                                    //   'Loading More',
                                    //   style: TextStyle(
                                    //     fontSize: 12,
                                    //     color:
                                    //         Colors.white.withOpacity(0.5),
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
                                          movie: topRatedMovies[index],
                                        )));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                      borderRadius: BorderRadius.circular(8),
                                      clipBehavior: Clip.hardEdge,
                                      child: Container(
                                        height: 160,
                                        width: 120,
                                        foregroundDecoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF002244)
                                                    .withOpacity(0.0),
                                                Color(0xFF111544)
                                              ],
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              topRatedMovies[index].poster,
                                          placeholder: (context, url) =>
                                              Container(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                          errorWidget: (context, url, child) =>
                                              Container(
                                            color: Colors.grey[800],
                                          ),
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
                                      topRatedMovies[index].title,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      CustomDeviderLight(),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 16, right: 16),
                        child: Text(
                          'All Movies',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
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
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => MoviePage(
                                                  movie: snapshot
                                                      .data.movies[index],
                                                )));
                                  },
                                  child: Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          clipBehavior: Clip.hardEdge,
                                          child: Container(
                                            width: 120,
                                            height: 200,
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data.movies[index].poster,
                                              placeholder: (context, url) =>
                                                  Container(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, child) =>
                                                      Container(
                                                color: Colors.grey[800],
                                              ),
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
                                                    snapshot.data.movies[index]
                                                        .title,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white
                                                          .withOpacity(0.65),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 12),
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
                                                              .withOpacity(
                                                                  0.75),
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
          Positioned(
            top: isSearching ? 0 : MediaQuery.of(context).size.height,
            bottom: isSearching ? 0 : MediaQuery.of(context).size.height * 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 36),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    child: Row(
                      children: <Widget>[
                        ButtonTheme(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.all(20),
                          minWidth: 0,
                          height: 0,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                isSearching = false;
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 24,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Search movies here'),
                            onChanged: (text) {
                              searchText = text;
                              searchProvider.notifyChanges();
                              // searchedMovies =
                              //     allMoviesData.movies.where((element) {
                              //   return element.title
                              //       .toLowerCase()
                              //       .contains(text);
                              // }).toList();
                              // searchedMovies = searchedMovies.sublist(0,
                              //     [searchedMovies.length - 1, 50].reduce(min));
                              //searchProvider.movies = searchedMovies;
                            },
                            onSubmitted: (text) {
                              searchProvider.notifyChanges();
                              //isSearching = false;
                              //setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  // FutureBuilder(
                  //   future: blocMoviesSearch.fetchMovies(searchText),
                  //   builder: (context, snapshot) {
                  //     if (!snapshot.hasData) {
                  //       print('Snapshot has no data for $searchText');
                  //       return DoTheSearchWidget();
                  //     }
                  //     print(
                  //         'Snapshot has some data of length: ${snapshot.data.length}');
                  //     return snapshot.data.length > 0
                  //         ? GridView.builder(
                  //             padding: const EdgeInsets.all(10),
                  //             shrinkWrap: true,
                  //             //physics: NeverScrollableScrollPhysics(),
                  //             itemCount: snapshot.data.length,
                  //             gridDelegate:
                  //                 SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 3,
                  //             ),
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return new Card(
                  //                 child: new GridTile(
                  //                   footer:
                  //                       new Text(snapshot.data[index].title),
                  //                   child: new Text(snapshot.data[index].rating
                  //                       .toString()), //just for testing, will fill with image later
                  //                 ),
                  //               );
                  //             },
                  //           )
                  //         : NoResultsWidget();
                  //   },
                  // ),
                  ChangeNotifierProvider(
                    create: (_) {
                      return searchProvider;
                    },
                    child: Consumer<SearchProvider>(
                      builder: (_, __, ___) {
                        return Flexible(
                          child: searchText.length > 0
                              ? FutureBuilder(
                                  future:
                                      blocMoviesSearch.fetchMovies(searchText),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      print(
                                          'Snapshot has no data for $searchText');
                                      return DoTheSearchWidget();
                                    }
                                    print(
                                        'Snapshot has some data of length: ${snapshot.data.length}');
                                    return snapshot.data.length > 0
                                        ? GridView.builder(
                                            padding: const EdgeInsets.all(10),
                                            shrinkWrap: true,
                                            //physics: NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MoviePage(
                                                                movie: snapshot
                                                                        .data[
                                                                    index],
                                                              )));
                                                },
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 6),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[900],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: Colors.indigo
                                                              .withOpacity(
                                                                  0.15),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Color(
                                                                      0xFF333388)
                                                                  .withOpacity(
                                                                      0.25),
                                                              blurRadius: 40,
                                                              offset: Offset(
                                                                  0, 12)),
                                                        ],
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        child: Container(
                                                          height: 160,
                                                          width: 120,
                                                          foregroundDecoration:
                                                              BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Colors.black
                                                                      .withOpacity(
                                                                          0),
                                                                  Colors.indigo[
                                                                      800]
                                                                ],
                                                                begin: Alignment
                                                                    .topRight,
                                                                end: Alignment
                                                                    .bottomLeft),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: snapshot
                                                                .data[index]
                                                                .poster,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                              child:
                                                                  CupertinoActivityIndicator(),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        child) =>
                                                                    Container(
                                                              color: Colors
                                                                  .grey[800],
                                                            ),
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
                                                        snapshot
                                                            .data[index].title,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : NoResultsWidget();
                                  },
                                )
                              : DoTheSearchWidget(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 36,
            left: 0,
            child: Visibility(
              visible: !isSearching,
              child: ButtonTheme(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(20),
                minWidth: 0,
                height: 0,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
