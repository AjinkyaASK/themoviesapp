import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/ui/moviePageSliverHeader.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  MoviePage({
    Key key,
    this.movie,
  }) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Map<String, dynamic>> actorsData = [];

  void initActorsList() {
    actorsData.add({
      'title': 'Will Smith',
      'posterPath': 'assets/images/actor-posters/willsmith.jpg'
    });
    actorsData.add({
      'title': 'Jaden Smith',
      'posterPath': 'assets/images/actor-posters/jadensmith.jpg'
    });
    actorsData.add({
      'title': 'Thandie Newton',
      'posterPath': 'assets/images/actor-posters/thandienewton.jpg'
    });
    setState(() {});
  }

  @override
  void initState() {
    initActorsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181822),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: MoviePageSliverHeaderDelegate(
                posterPath: widget.movie.poster,
                backPosterPath: widget.movie.backPoster),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 800,
              child: Column(
                children: <Widget>[
                  Opacity(
                    opacity: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Text(
                                widget.movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 4,
                                        offset: Offset(1, 1))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    size: 24,
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 24,
                                    color: Colors.amber[200].withOpacity(0.75),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    widget.movie.rating.toString(),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w300,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 4,
                                            offset: Offset(1, 1))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite,
                                    size: 24,
                                    color: Colors.red[400],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Text(
                                      widget.movie.voteCount.toString(),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.remove_red_eye,
                                    size: 24,
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    widget.movie.popularity.toString(),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w300,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 4,
                                            offset: Offset(1, 1))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            margin: const EdgeInsets.only(bottom: 24, top: 12),
                            child: Text(
                              'Synopsis',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.05,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Text(
                            widget.movie.overview,
                            textAlign: TextAlign.justify,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.35),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            margin: const EdgeInsets.only(bottom: 18, top: 22),
                            child: Text(
                              'Read More',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32, bottom: 18, left: 8, right: 16),
                            child: Text(
                              'Actors',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.65),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            height: 144,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: actorsData.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: BorderRadius.circular(60),
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              Colors.indigo.withOpacity(0.15),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF333388)
                                                  .withOpacity(0.25),
                                              blurRadius: 10,
                                              offset: Offset(0, 4)),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          foregroundDecoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.black.withOpacity(0),
                                                  Colors.indigo[800]
                                                      .withOpacity(0.5)
                                                ],
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: actorsData[index]
                                                ['posterPath'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      margin: const EdgeInsets.only(top: 12),
                                      height: 40,
                                      width: 80,
                                      child: Text(
                                        //actorsData[index]['title'],
                                        '',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
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
