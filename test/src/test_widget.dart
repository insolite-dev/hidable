import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';

// Just a simple testing utility widget.
// Used to test, hidable widget and hidable controller.
class TestWidget extends StatelessWidget {
  final bool wOpacity;
  final ScrollController scrollController;

  const TestWidget({
    Key? key,
    required this.scrollController,
    this.wOpacity = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          controller: scrollController,
          children: List.generate(30, (index) => Text('Text $index')).toList(),
        ),
        bottomNavigationBar: Hidable(
          controller: scrollController,
          wOpacity: wOpacity,
          child: Container(
            height: kBottomNavigationBarHeight,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
