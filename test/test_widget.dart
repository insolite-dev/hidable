//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';

// Just a simple testing utility widget.
// Used to test, hidable widget and hidable controller.
class TestWidget extends StatelessWidget {
  final bool enableOpacityAnimation;
  final ScrollController scrollController;
  final bool wAppBar;

  const TestWidget({
    Key? key,
    required this.scrollController,
    this.enableOpacityAnimation = true,
    this.wAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: !wAppBar ? null : Hidable(child: AppBar(), controller: scrollController),
        body: ListView(
          controller: scrollController,
          children: List.generate(30, (index) => Text('Text $index')).toList(),
        ),
        bottomNavigationBar: wAppBar
            ? null
            : Hidable(
                controller: scrollController,
                enableOpacityAnimation: enableOpacityAnimation,
                child: Container(
                  height: kBottomNavigationBarHeight,
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}
