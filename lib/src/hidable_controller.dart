import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

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

  /// The main value notifier of widget's size.
  final sizeNotifier = ValueNotifier<double>(1.0);

  /// The main value notifier of widget's stickiness.
  final stickinessNotifier = ValueNotifier<bool>(false);

  /// Adds new state value to stickiness notifier.
  ///
  /// Basically, used to enable/disable stickness of widget.
  void setStickinessState(bool state) => stickinessNotifier.value = state;

  double li = 0.0, lastOffset = 0.0;
  double sizeFactor() => 1.0 - (li / size);

  /// Default listener that detects up/down scrolls and alerts size's value-notifier.
  void listener() {
    final p = scrollController.position;

    // Set "li" by pixels and last offset.
    li = (li + p.pixels - lastOffset).clamp(0.0, size);
    lastOffset = p.pixels;

    // If scrolled down, size-notifiers value should be zero.
    // Can be imagined as [zero - false] | [one - true].
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

  void dispose() {
    stickinessNotifier.dispose();
    sizeNotifier.dispose();
  }
}
