//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:flutter/widgets.dart';

import 'hidable_controller.dart';

/// Simple extension to generate [HidableController] from scroll controller instance directly.
extension HidableControllerExt on ScrollController {
  static final hidableControllers = <int, HidableController>{};

  /// Shortcut way of creating hidable controller
  HidableController hidable(size) {
    // If the same instance was created before, we should keep using it.
    if (hidableControllers.containsKey(hashCode)) {
      return hidableControllers[hashCode]!;
    }

    return hidableControllers[hashCode] = HidableController(
      scrollController: this,
      size: size,
    );
  }
}
