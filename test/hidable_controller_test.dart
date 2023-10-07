//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hidable/src/hidable_controller.dart';

import 'test_widget.dart';

void main() {
  const kSize = kBottomNavigationBarHeight;

  late ScrollController controller;
  late ScrollController controllerFromHidable;

  setUpAll(() {
    controller = ScrollController();
    controllerFromHidable = controller.hidable(kSize, 0, null).scrollController;
  });

  group("HidableControllerExt", () {
    test('should generate hidable controller from scroll controller', () {
      final hidable = controller.hidable(kBottomNavigationBarHeight, 1, (p, po, co, cv) {
        return 1;
      });
      expect(hidable.runtimeType, HidableController);

      final reCreatedHidable = controller.hidable(kBottomNavigationBarHeight, 1, null);
      expect(hidable, reCreatedHidable);
    });
  });

  group("HidableController", () {
    test('size factor should return right value', () {
      final hidable = controller.hidable(kSize, 2, null);

      final factor = 1 - (hidable.previousOffset / hidable.size);
      expect(hidable.calculateVisiblePercentage(), factor);
    });

    testWidgets(
      'listener should work correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          TestWidget(scrollController: controllerFromHidable),
        );

        expect(find.byType(Align), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget);
        expect(find.byType(Opacity), findsOneWidget);

        controllerFromHidable.jumpTo(20);
        await tester.pumpAndSettle();

        controllerFromHidable.jumpTo(-20);
        await tester.pumpAndSettle();
      },
    );

    test(
      'close should disable value notifiers correctly',
      () => controller.hidable(kSize, 3, null).close(),
    );
  });
}
