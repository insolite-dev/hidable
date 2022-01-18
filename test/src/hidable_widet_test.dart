// Copyright 2021-2022 present Anon. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'test_widget.dart';

// ignore: avoid_relative_lib_imports
import '../../lib/src/hidable_controller_ext.dart';

void main() {
  late ScrollController scrollController;

  setUpAll(() {
    scrollController = ScrollController();
  });

  group('Hidable Widget', () {
    testWidgets(
      'should work correctly as default',
      (WidgetTester tester) async {
        await tester.pumpWidget(TestWidget(scrollController: scrollController));

        expect(find.byType(Align), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget);
        expect(find.byType(Opacity), findsOneWidget);

        scrollController.jumpTo(10);
      },
    );

    testWidgets(
      'should work correctly without opacity and as sticked',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          TestWidget(scrollController: scrollController, wOpacity: false),
        );

        scrollController
            .hidable(kBottomNavigationBarHeight)
            .setStickinessState(true);

        expect(find.byType(Opacity), findsNothing);
      },
    );
  });
}
