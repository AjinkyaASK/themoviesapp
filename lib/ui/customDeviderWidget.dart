import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDeviderLight extends StatelessWidget {
  const CustomDeviderLight({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      height: 1,
      width: double.maxFinite,
      color: Colors.white.withOpacity(0.05),
    );
  }
}
