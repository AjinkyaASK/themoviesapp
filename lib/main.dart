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
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> moviesData = [
      {
        'title': 'The Persuit of Happiness',
        'rating': 4,
        'votes': 1024,
        'released': 'April 4, 1995',
        'posterPath': 'assets/images/movie-posters/1.jpg'
      },
      {
        'title': 'The Shawshank Redemption',
        'rating': 4,
        'votes': 986,
        'released': 'December 12, 1994',
        'posterPath': 'assets/images/movie-posters/2.jpg'
      },
      {
        'title': 'Good Will Hunting',
        'rating': 5,
        'votes': 1050,
        'released': 'January 9, 1998',
        'posterPath': 'assets/images/movie-posters/3.jpg'
      },
      {
        'title': 'The Green Mile',
        'rating': 5,
        'votes': 1175,
        'released': 'May 1, 1993',
        'posterPath': 'assets/images/movie-posters/4.jpg'
      },
      {
        'title': 'The Longest Yard',
        'rating': 4,
        'votes': 875,
        'released': 'August 15, 1993',
        'posterPath': 'assets/images/movie-posters/5.jpg'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: HomePageSliverHeaderDelegate(),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 800,
              color: Color(0xFF090909),
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
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: moviesData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 250,
                              width: 190,
                              margin: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 0,
                              ),
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
                                      blurRadius: 20,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 16),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
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
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: moviesData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 250,
                              width: 190,
                              margin: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 0,
                              ),
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
                                      blurRadius: 20,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 16),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
