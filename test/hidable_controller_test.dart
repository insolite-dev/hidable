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
  late ScrollController controller;
  late ScrollController controllerFromHidable;

  setUpAll(() {
    controller = ScrollController();
    controllerFromHidable = controller.hidable(0, null, 0.08).scrollController;
  });

  group("HidableControllerExt", () {
    test('should generate hidable controller from scroll controller', () {
      final hidable = controller.hidable(1, (p, cv) {
        return 1;
      }, 0.08);
      expect(hidable.runtimeType, HidableController);

      final reCreatedHidable = controller.hidable(1, null, 0.08);
      expect(hidable, reCreatedHidable);
    });
  });

  group("HidableController", () {
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
      () => controller.hidable(1, null, 0.08).close(),
    );
  });
}
