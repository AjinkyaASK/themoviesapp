import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoResultsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 125,
              color: Colors.white.withOpacity(0.25),
            ),
            SizedBox(height: 12),
            Text(
              'No Results',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.65),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Looks like the movie you are searching is not in our database, please try with something else.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoTheSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.search,
              size: 125,
              color: Colors.white.withOpacity(0.25),
            ),
            SizedBox(height: 12),
            Text(
              'Search it on!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.65),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Search and enjoy any movie from the large database of ours.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
