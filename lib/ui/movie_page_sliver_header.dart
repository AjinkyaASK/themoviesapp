import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:themoviesapp/utils/constants.dart';

class MoviePageSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Movie movie;

  MoviePageSliverHeaderDelegate({this.movie});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkFactor = (maxExtent - shrinkOffset) /
        maxExtent; //The shrinkFactor is calculated as how much scrollable header area is remaining
    double shrinkFactorEnhanced = pow(shrinkFactor,
        6); //Enhances the shrinkOffset by making it reach 0, 5 times faster

    return Opacity(
      opacity: shrinkFactorEnhanced,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            foregroundDecoration: BoxDecoration(
              color: Colors.indigo[600],
              gradient: LinearGradient(
                colors: [
                  Colors.indigo[500].withOpacity(0.5),
                  DefaultBackgroundColor,
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
            child: CachedNetworkImage(
              imageUrl: movie.backPoster,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 125,
                margin: const EdgeInsets.fromLTRB(20, 90, 20, 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 60, color: Colors.black),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: movie.poster,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 8),
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
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(${movie.voteCount})',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Score: ${movie.rating}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              SizedBox(width: 24),
            ],
          ),
          Positioned(
            top: 20 + MediaQuery.of(context).padding.top,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
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

  @override
  double get maxExtent => 320;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
