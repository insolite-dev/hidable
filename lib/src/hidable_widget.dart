//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:hidable/src/hidable_controller.dart';

/// Hidable is a widget that makes any static located widget hideable while scrolling.
///
/// To use Hidable, wrap your static located widget with [Hidable].
/// This will enable scroll-to-hide functionality for the widget.
///
/// Note: The scroll controller provided to [Hidable] must also be given to your scrollable widget,
/// such as [ListView], [GridView], etc.
///
/// For more information, refer to the [documentation](https://github.com/insolite-dev/hidable#readme).
class Hidable extends StatelessWidget implements PreferredSizeWidget {
  /// The child widget to which you want to add scroll-to-hide effect.
  ///
  /// This should be a static located widget, such as [BottomNavigationBar], [FloatingActionButton], [AppBar], etc.
  final Widget child;

  /// The main scroll controller that listens to user's scrolls.
  ///
  /// This scroll controller must also be provided to your scrollable widget.
  final ScrollController controller;

  /// Enable or disable opacity animation.
  ///
  /// This property is deprecated. Use [enableOpacityAnimation] instead.
  @Deprecated('Use enableOpacityAnimation instead.')
  final bool wOpacity;

  /// Enable or disable opacity animation.
  ///
  /// Defaults to `true`.
  final bool enableOpacityAnimation;

  /// A customization field for [Hidable]'s `preferredSize`.
  ///
  /// As default the preferred size is is the [AppBar]'s `preferredSize`.
  /// (56 heights with page-size width).
  final Size preferredWidgetSize;

  const Hidable({
    Key? key,
    required this.child,
    required this.controller,
    @deprecated this.wOpacity = true,
    this.enableOpacityAnimation = true,
    this.preferredWidgetSize = const Size.fromHeight(56),
  }) : super(key: key);

  @override
  Size get preferredSize => preferredWidgetSize;

  @override
  Widget build(BuildContext context) {
    final hidable = controller.hidable(preferredWidgetSize.height, hashCode);
    return ValueListenableBuilder<double>(
      valueListenable: hidable.visibilityNotifier,
      builder: (_, factor, __) => Align(
        heightFactor: factor,
        alignment: const Alignment(0, -1),
        child: SizedBox(
          height: hidable.size,
          child: enableOpacityAnimation ? Opacity(opacity: factor, child: child) : child,
        ),
      ),
    );
  }
}
