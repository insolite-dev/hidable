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
        expect(find.byType(Material), findsNWidgets(2));
        expect(find.byType(Container), findsNWidgets(2));
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
