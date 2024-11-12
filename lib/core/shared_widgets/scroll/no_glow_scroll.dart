// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NoGlowScroll extends StatelessWidget {
  final Widget child;
  final bool isDefaultScroll;
  final ScrollPhysics? physics;
  const NoGlowScroll({super.key,  this.isDefaultScroll= true, required this.child, this.physics});

  @override
  Widget build(BuildContext context) {
    return  ScrollConfiguration(  behavior: NoGlowScrollBehavior(), child: SingleChildScrollView(
      physics:physics ,
      child:child ,
    ),);
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
@override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
