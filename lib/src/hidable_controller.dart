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
  HidableController hidable(double size, int hashCode, HidableVisibility? visibility) {
    // If the same instance was created before, we should keep using it.
    if (hidableControllers.containsKey(hashCode)) {
      return hidableControllers[hashCode]!;
    }

    return hidableControllers[hashCode] = HidableController(
      scrollController: this,
      size: size,
      hideableVisibility: visibility,
    );
  }
}

/// Defines a function signature for determining the visibility of a scrollable element
/// that can be hidden or revealed based on scrolling behavior.
///
/// The `HidableVisibility` function takes four parameters:
/// - `position`: A [ScrollPosition] object representing the current scroll position.
/// - `previousOffset`: A [double] representing the previous scroll offset before the update.
/// - `currentOffset`: A [double] representing the current scroll offset after the update.
/// - `currentVisibility`: A [double] representing the current visibility status, typically
///   a value between 0.0 (completely hidden) and 1.0 (completely visible).
///
/// The function should return a [double] value representing the updated visibility status
/// of the scrollable element, typically also in the range of 0.0 to 1.0.
///
/// Example usage:
/// ```dart
/// HidableVisibility myVisibilityFunction(
///   ScrollPosition position,
///   double previousOffset,
///   double currentOffset,
///   double currentVisibility,
/// ) {
///   // Your visibility logic here.
///   // Return the updated visibility value.
/// }
/// ```
///
/// This typedef is often used in conjunction with a [HidableController] to define custom
/// visibility behavior for scrollable elements.
typedef HidableVisibility = double Function(
  ScrollPosition position,
  double previousOffset,
  double currentOffset,
  double currentVisibility,
);

/// A custom wrapper for scroll controller.
///
/// Implements the main listener mehtod for [ScrollController].
/// And the [sizeNotifier] for providing/updating the hideable status.
class HidableController {
  ScrollController scrollController;
  double size;
  HidableVisibility? hideableVisibility;

  HidableController({
    required this.scrollController,
    required this.size,
    this.hideableVisibility,
  }) {
    scrollController.addListener(() => updateVisibility(hideableVisibility));
  }

  double previousOffset = 0.0;
  double visiblePercentage = 1.0;

  final visibilityNotifier = ValueNotifier<double>(1.0);

  double calculateVisiblePercentage() => 1.0 - (previousOffset / size);

  void updateVisibility(HidableVisibility? visibility) {
    final position = scrollController.position;
    final currentOffset = position.pixels;

    previousOffset = (previousOffset + currentOffset - previousOffset).clamp(0.0, size);

    if (visibility != null) {
      visibilityNotifier.value = visibility(
        position,
        previousOffset,
        currentOffset,
        visibilityNotifier.value,
      );
      return;
    }

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
