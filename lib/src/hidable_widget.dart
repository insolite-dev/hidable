// Copyright 2021-2022 present Anon. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hidable/src/hidable_controller_ext.dart';

/// ### Widget that can make anything hidable.
///
/// Wrap your static located widget with [Hidable],
/// then your widget will support scroll to hide/show feature.
///
/// Note: scroll controller that you give to [Hidable], also must be given to your scrollable widget,
/// It could, [ListView], [GridView], etc.
///
/// #### For more information refer to - [documentation](https://github.com/anonistas/hidable#readme)
class Hidable extends StatelessWidget with PreferredSizeWidget {
  /// Child widget, which you want to add scroll-to-hide effect to it.
  ///
  /// It should be static located widget:
  /// [BottomNavigationBar], [FloatingActionButton], [AppBar] etc.
  final Widget child;

  /// The main scroll controller to listen user's scrolls.
  ///
  /// It must be given to your scrollable widget.
  final ScrollController controller;

  /// The size (height) of widget that you provide as [child].
  final double size;

  /// Enable/Disable opacity animation. As default it's enabled (true).
  final bool wOpacity;

  /// A customization field for [Hidable]'s `preferredSize`.
  ///
  /// As default the preferred size is is the [AppBar]'s `preferredSize`.
  /// (56 heights with page-size width).
  final Size? preferredWidgetSize;

  const Hidable({
    Key? key,
    required this.child,
    required this.controller,
    this.size = kBottomNavigationBarHeight,
    this.wOpacity = true,
    this.preferredWidgetSize,
  }) : super(key: key);

  @override
  Size get preferredSize => preferredWidgetSize ?? const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final hidable = controller.hidable(size);

    return ValueListenableBuilder<bool>(
      valueListenable: hidable.stickinessNotifier,
      builder: (_, isStickinessEnabled, __) {
        // If stickiness of hidable was enabled, return card with one factor.
        // So, that hidable's movement would be disabled.
        if (isStickinessEnabled) return hidableCard(1.0, hidable);

        return ValueListenableBuilder<double>(
          valueListenable: hidable.sizeNotifier,
          builder: (_, height, __) => hidableCard(height, hidable),
        );
      },
    );
  }

  // Custom alignment wrapper card of hidable.
  // Returns whole card at given factor.
  Widget hidableCard(double factor, hidable) {
    return Align(
      heightFactor: factor,
      alignment: const Alignment(0, -1),
      child: SizedBox(
        height: hidable.size,
        child: wOpacity ? Opacity(opacity: factor, child: child) : child,
      ),
    );
  }
}
