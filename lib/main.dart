import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviesapp/ui/homePageSliverHeader.dart';

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
  List<Map<String, dynamic>> moviesData = [];

  bool isNowPlayingListLoading = false;

  void initMoviesList() {
    moviesData.add({
      'title': 'The Persuit of Happiness',
      'language': 'English',
      'rating': 4,
      'votes': 1024,
      'released': 'April 4, 1995',
      'posterPath': 'assets/images/movie-posters/1.jpg'
    });
    moviesData.add({
      'title': 'The Shawshank Redemption',
      'language': 'English',
      'rating': 4,
      'votes': 986,
      'released': 'December 12, 1994',
      'posterPath': 'assets/images/movie-posters/2.jpg'
    });
    moviesData.add({
      'title': 'Good Will Hunting',
      'language': 'English',
      'rating': 5,
      'votes': 1050,
      'released': 'January 9, 1998',
      'posterPath': 'assets/images/movie-posters/3.jpg'
    });
    moviesData.add({
      'title': 'The Green Mile',
      'language': 'English',
      'rating': 5,
      'votes': 1175,
      'released': 'May 1, 1993',
      'posterPath': 'assets/images/movie-posters/4.jpg'
    });
    moviesData.add({
      'title': 'The Longest Yard',
      'language': 'English',
      'rating': 4,
      'votes': 875,
      'released': 'August 15, 1993',
      'posterPath': 'assets/images/movie-posters/5.jpg'
    });
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
    _nowPlayingScrollController.addListener(() {
      if (_nowPlayingScrollController.position.maxScrollExtent ==
          _nowPlayingScrollController.position.pixels) {
        print('Reched List End');
        if (!isNowPlayingListLoading) {
          isNowPlayingListLoading = !isNowPlayingListLoading;
        }
        // setState(() {
        //   moviesData.add({
        //     'title': 'The Longest Yard 2',
        //     'language': 'English',
        //     'rating': 4,
        //     'votes': 875,
        //     'released': 'August 15, 1993',
        //     'posterPath': 'assets/images/movie-posters/1.jpg'
        //   });
        // });
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
                  Container(
                    height: 290,
                    child: ListView.builder(
                      controller: _nowPlayingScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: moviesData.length + 1,
                      itemBuilder: (context, index) {
                        if (index == moviesData.length) {
                          return Container(
                            width: 120,
                            height: 290,
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
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 250,
                              width: 190,
                              margin: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.indigo.withOpacity(0.15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Color(0xFF333388).withOpacity(0.35),
                                      blurRadius: 40,
                                      offset: Offset(0, 12)),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  moviesData[index]['posterPath'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: 40,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                moviesData[index]['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.65),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, bottom: 18, left: 16, right: 16),
                    child: Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.65),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: moviesData.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.indigo.withOpacity(0.15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Color(0xFF333388).withOpacity(0.25),
                                      blurRadius: 40,
                                      offset: Offset(0, 12)),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  height: 120,
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
                                  child: Image.asset(
                                    moviesData[index]['posterPath'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              bottom: 10,
                              child: RichText(
                                text: TextSpan(
                                  text: '#',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white.withOpacity(0.65),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
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
                  Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: moviesData.length,
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
                                color: Color(0xFF151518),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.indigo.withOpacity(0.15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Color(0xFF333388).withOpacity(0.35),
                                      blurRadius: 40,
                                      offset: Offset(0, 12)),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    clipBehavior: Clip.hardEdge,
                                    child: Container(
                                      width: 120,
                                      height: 200,
                                      child: Image.asset(
                                        moviesData[index]['posterPath'],
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
                                              moviesData[index]['title'],
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                                    .withOpacity(0.65),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            height: 2,
                                            width: 34,
                                            color: Colors.indigo[400],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.grey[300]
                                                    .withOpacity(0.8),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: Text(
                                                  '(${moviesData[index]['votes']})',
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
                                            padding: EdgeInsets.only(top: 12),
                                            child: Text(
                                              'Languages: ${moviesData[index]['language']}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                                    .withOpacity(0.65),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              'Release: ${moviesData[index]['released']}',
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
