// Copyright 2021-2022 present Anon. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.

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
