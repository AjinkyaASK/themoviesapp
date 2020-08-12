import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/ui/icon_label_container_border_circular.dart';
import 'package:themoviesapp/ui/moviePageSliverHeader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:themoviesapp/utils/constants.dart';

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
      backgroundColor: DefaultBackgroundColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: MoviePageSliverHeaderDelegate(movie: widget.movie),
          ),
          SliverToBoxAdapter(
            child: Container(
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
                          SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconLabelContainerBorderCircular(
                                iconData: Icons.language,
                                title: 'English',
                                color: Colors.white.withOpacity(0.75),
                              ),
                              IconLabelContainerBorderCircular(
                                iconData: Icons.favorite,
                                title: widget.movie.popularity.toString(),
                                color: Colors.red.withOpacity(0.75),
                              ),
                              IconLabelContainerBorderCircular(
                                iconData: Icons.star,
                                title: widget.movie.rating.toString(),
                                color: Colors.amber.withOpacity(0.75),
                              ),
                              IconLabelContainerBorderCircular(
                                iconData: Icons.remove_red_eye,
                                title: widget.movie.voteCount.toString(),
                                color: Colors.white.withOpacity(0.75),
                              ),
                              IconLabelContainerBorderCircular(
                                iconData: Icons.remove_red_eye,
                                title: widget.movie.voteCount.toString(),
                                color: Colors.white.withOpacity(0.75),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Text(
                            'Synopsis',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.05,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 2,
                            color: Colors.white.withOpacity(0.25),
                            margin: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          Text(
                            widget.movie.overview,
                            textAlign: TextAlign.justify,
                            maxLines: 20,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Colors.white.withOpacity(0.65),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                // border: Border.all(
                                //   color: Colors.white.withOpacity(0.35),
                                //   width: 0.5,
                                // ),
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
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
