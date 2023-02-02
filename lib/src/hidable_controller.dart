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

  /// Shortcut way of creating hidable controller
  HidableController hidable(double size) {
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
  /// The main scroll controller.
  ScrollController scrollController;

  /// Default size of widget, that [HidableController] gonna be used for it.
  double size;

  HidableController({
    required this.scrollController,
    required this.size,
  }) {
    scrollController.addListener(listener);
  }

  double li = 0.0, lastOffset = 0.0;

  final sizeNotifier = ValueNotifier<double>(1.0);

  /// Took size factor from "li" and "size".
  double sizeFactor() => 1.0 - (li / size);

  /// Listener is the main "extenssion" method for the [ScrollController],
  /// which calculates the position of scroll and decides wheter it should collapse or 
  /// show-up the static located widget.
  ///
  /// The caluclation data will be emited to the [sizeNotifier]. Where 0 to 1 is the 
  /// static-located-widget appearing status. (0 = closed) and (1 = opened).
  void listener() {
    final p = scrollController.position;

    // Set "li" by pixels and last offset.
    li = (li + p.pixels - lastOffset).clamp(0.0, size);
    lastOffset = p.pixels;

    // If scrolled down, size-notifiers value should be zero.
    // Can be imagined as [zero = false] | [one = true].
    if (p.axisDirection == AxisDirection.down && p.extentAfter == 0.0) {
      if (sizeNotifier.value == 0.0) return;

      sizeNotifier.value = 0.0;
      return;
    }

    // If scrolled up, size-notifiers value should be one.
    // Can be imagined as [zero - false] | [one - true].
    if (p.axisDirection == AxisDirection.up && p.extentBefore == 0.0) {
      if (sizeNotifier.value == 1.0) return;

      sizeNotifier.value = 1.0;
      return;
    }

    final isZeroValued = li == 0.0 && sizeNotifier.value == 0.0;
    if (isZeroValued || (li == size && sizeNotifier.value == 1.0)) return;

    sizeNotifier.value = sizeFactor();
  }

  void close() => sizeNotifier.dispose();
}
