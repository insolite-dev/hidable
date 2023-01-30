//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:hidable/src/hidable_controller_ext.dart';

/// Hidable is a widget that makes any static located widget hideable while scrolling.
///
/// To Use:
/// Wrap your static located widget with [Hidable],
/// then your widget will support scroll to hide/show feature.
///
/// Note: scroll controller that you give to [Hidable], also must be given to your scrollable widget,
/// It could, [ListView], [GridView], etc.
///
/// #### For more information refer to - [documentation](https://github.com/insolite-dev/hidable#readme)
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

  /// Enable/Disable opacity animation. As default it's enabled (true).
  final bool wOpacity;

  /// A customization field for [Hidable]'s `preferredSize`.
  ///
  /// As default the preferred size is is the [AppBar]'s `preferredSize`.
  /// (56 heights with page-size width).
  final Size preferredWidgetSize;

  const Hidable({
    Key? key,
    required this.child,
    required this.controller,
    this.wOpacity = true,
    this.preferredWidgetSize = const Size.fromHeight(56),
  }) : super(key: key);

  @override
  Size get preferredSize => preferredWidgetSize;

  @override
  Widget build(BuildContext context) {
    final hidable = controller.hidable(preferredWidgetSize.height);

    return ValueListenableBuilder<double>(
      valueListenable: hidable.sizeNotifier,
      builder: (_, factor, __) => Align(
        heightFactor: factor,
        alignment: const Alignment(0, -1),
        child: SizedBox(
          height: hidable.size,
          child: wOpacity ? Opacity(opacity: factor, child: child) : child,
        ),
      ),
    );
  }
}
