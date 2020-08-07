import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkFactor = (maxExtent - shrinkOffset) /
        maxExtent; //The shrinkFactor is calculated as how much scrollable header area is remaining
    double shrinkFactorEnhanced = pow(shrinkFactor,
        6); //Enhances the shrinkOffset by making it reach 0, 5 times faster

    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Container(
          color: Colors.indigo[500],
          constraints: BoxConstraints.expand(),
          foregroundDecoration: BoxDecoration(
            color: Colors.indigo[600],
            gradient: LinearGradient(
              colors: [
                Colors.indigo[500].withOpacity(0.8),
                Color(0xFF181822),
              ],
              stops: [0, shrinkFactor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            // border: Border(
            //   bottom: BorderSide(
            //       color: Colors.indigo.withOpacity(0.35), width: 0.5),
            // ),
          ),
          child: Opacity(
            opacity: shrinkFactorEnhanced,
            child: Image.asset(
              'assets/images/movie-posters/1.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        Opacity(
          opacity: shrinkFactorEnhanced,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'Top Grossing',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.05,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Flexible(
                  child: Text(
                    'The Persuit of Happiness Happiness Happiness Happiness Happiness ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.lightBlue,
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.lightBlue,
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.lightBlue,
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.lightBlue,
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.grey[300].withOpacity(0.8),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          '(1,024)',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Released April 4, 1995',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20 + MediaQuery.of(context).padding.top,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.search,
                size: 24,
                color: Colors.white.withOpacity(0.75),
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
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
