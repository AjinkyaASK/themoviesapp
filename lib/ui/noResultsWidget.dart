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
            Text(
              'No Results',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Looks like the movie you are searching is not in our database, please try with something else.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.58),
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
        padding: const EdgeInsets.all(36),
        child: Column(
          children: <Widget>[
            Text(
              'Search it on!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Search and enjoy any movie from the large database of ours.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.58),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
