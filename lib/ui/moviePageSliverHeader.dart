import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviePageSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String posterPath;

  MoviePageSliverHeaderDelegate({this.posterPath});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkFactor = (maxExtent - shrinkOffset) /
        maxExtent; //The shrinkFactor is calculated as how much scrollable header area is remaining
    double shrinkFactorEnhanced = pow(shrinkFactor,
        6); //Enhances the shrinkOffset by making it reach 0, 5 times faster

    return Stack(
      alignment: Alignment.bottomCenter,
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
            child: CachedNetworkImage(
              imageUrl: posterPath,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        Opacity(
          opacity: shrinkFactorEnhanced,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: 300,
            margin: const EdgeInsets.fromLTRB(20, 90, 20, 0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 60, color: Colors.black),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: posterPath,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
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
                Icons.arrow_back_ios,
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
  double get maxExtent => 350;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
