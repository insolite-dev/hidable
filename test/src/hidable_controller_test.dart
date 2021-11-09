import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_relative_lib_imports
import '../../lib/src/hidable_controller_ext.dart';
import 'test_widget.dart';

void main() {
  const kSize = kBottomNavigationBarHeight;

  late ScrollController controller;
  late ScrollController controllerFromHidable;

  setUpAll(() {
    controller = ScrollController();
    controllerFromHidable = controller.hidable(kSize).scrollController;
  });

  group("HidableController", () {
    test('setting stickiness should work correctly', () {
      final hidable = controller.hidable(kSize);

      hidable.setStickinessState(true);
      expect(controller.hidable(kSize).stickinessNotifier.value, true);

      hidable.setStickinessState(false);
      expect(controller.hidable(kSize).stickinessNotifier.value, false);
    });

    test('size factor should return right value', () {
      final hidable = controller.hidable(kSize);

      final factor = 1 - (hidable.li / hidable.size);
      expect(hidable.sizeFactor(), factor);
    });

    testWidgets(
      'listener should work correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          TestWidget(scrollController: controllerFromHidable),
        );

        expect(find.byType(Align), findsOneWidget);
        expect(find.byType(Material), findsNWidgets(2));
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
      () => controller.hidable(kSize).close(),
    );
  });
}
