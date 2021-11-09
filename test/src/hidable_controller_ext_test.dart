import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hidable/src/hidable_controller.dart';
import 'package:hidable/src/hidable_controller_ext.dart';

void main() {
  late ScrollController scrollController;

  setUpAll(() {
    scrollController = ScrollController();
  });

  group("HidableControllerExt", () {
    test('should generate hidable controller from scroll controller', () {
      final hidable = scrollController.hidable(kBottomNavigationBarHeight);
      expect(hidable.runtimeType, HidableController);

      final reCreatedHidable = scrollController.hidable(
        kBottomNavigationBarHeight,
      );
      expect(hidable, reCreatedHidable);
    });
  });
}
