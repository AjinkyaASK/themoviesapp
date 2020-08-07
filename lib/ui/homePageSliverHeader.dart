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
          constraints: BoxConstraints.expand(),
          foregroundDecoration: BoxDecoration(
            color: Colors.indigo[600],
            gradient: LinearGradient(
              colors: [
                Colors.indigo[500].withOpacity(0.8),
                Color(0xFF090909),
              ],
              stops: [0, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              bottom: BorderSide(
                  color: Colors.indigo.withOpacity(0.35), width: 0.5),
            ),
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
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
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
