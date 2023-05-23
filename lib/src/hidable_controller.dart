//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

/// Simple extension to generate [HidableController] from scroll controller instance directly.
extension HidableControllerExt on ScrollController {
  static final hidableControllers = <int, HidableController>{};

  /// Creates new [HidableController] or returns already created existing [HidableController]
  /// from [hidableControllers].
  ///
  /// Identifys each controller via passed [hashCode] property.
  HidableController hidable(double size, int hashCode) {
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

/// A custom wrapper for scroll controller.
///
/// Implements the main listener mehtod for [ScrollController].
/// And the [sizeNotifier] for providing/updating the hideable status.
class HidableController {
  ScrollController scrollController;
  double size;
  double previousOffset = 0.0;
  double visiblePercentage = 1.0;

  final visibilityNotifier = ValueNotifier<double>(1.0);

  HidableController({
    required this.scrollController,
    required this.size,
  }) {
    scrollController.addListener(updateVisibility);
  }

  double calculateVisiblePercentage() => 1.0 - (previousOffset / size);

  void updateVisibility() {
    final position = scrollController.position;
    final currentOffset = position.pixels;

    previousOffset = (previousOffset + currentOffset - previousOffset).clamp(0.0, size);

    if (position.axisDirection == AxisDirection.down && position.extentAfter == 0.0) {
      if (visibilityNotifier.value == 0.0) return;
      visibilityNotifier.value = 0.0;
      return;
    }

    if (position.axisDirection == AxisDirection.up && position.extentBefore == 0.0) {
      if (visibilityNotifier.value == 1.0) return;
      visibilityNotifier.value = 1.0;
      return;
    }

    final isFullyVisible = previousOffset == 0.0 && visibilityNotifier.value == 0.0;
    if (isFullyVisible || (previousOffset == size && visibilityNotifier.value == 1.0)) return;

    visibilityNotifier.value = calculateVisiblePercentage();
  }

  void close() => visibilityNotifier.dispose();
}
