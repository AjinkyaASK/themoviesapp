import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconLabelContainerBorderCircular extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color color;

  const IconLabelContainerBorderCircular({
    Key key,
    this.iconData,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            iconData,
            size: 24,
            color: color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.75),
            ),
          ),
        ),
      ],
    );
  }
}
