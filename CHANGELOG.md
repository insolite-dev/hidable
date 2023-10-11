# v1.0.6 - 12/10/2023

- Resolved [#26](https://github.com/insolite-dev/hidable/issues/26)
- Added `deltaFactor` field which controls the speed of hiding/appearing speed of hidable.
- Added `visibility` field which makes it able for user to provide custom scrolling algorithm
  instead of using default.

Huge thanks for feature request to [@radibobovich](https://github.com/radibobovich)

# v1.0.5 - 25/08/2023

- Resolved [#21](https://github.com/insolite-dev/hidable/issues/21)
- Deprecate the [wOpacity] property and add new [enableOpacityAnimation]
  instead.

# v1.0.4 - 14/05/2023

- Migrated to Flutter 3.10 and Dart 3
  - Resolved [#17](https://github.com/insolite-dev/hidable/issues/17)

# v1.0.3 - 03/09/2022

- Resolved [#10](https://github.com/insolite-dev/hidable/issues/10)

# v1.0.2 - 18/01/2022

- Resolved [#6](https://github.com/insolite-dev/hidable/issues/6)

# v1.0.1 - 10/11/2021

- Resolved: [#3](https://github.com/insolite-dev/hidable/issues/3) and [#4](https://github.com/insolite-dev/hidable/issues/4)
- Updated documentation comments and pub points of package.

# v1.0.0 - 09/11/2021

<p align="center">
 <img width="300" src="https://user-images.githubusercontent.com/59066341/140976777-712cd333-9f82-4f92-8e03-33cb93f18650.png" alt="Package Logo">
</p>

**The very first version of the Hidable package!**
**So that can add scroll-to-hide effect to any static located widget - AppBar, BottomNavigationBar, etc.**

#### Overview
<img width="250" src="https://user-images.githubusercontent.com/59066341/140974710-bfd27779-be3e-4068-aa80-46b2ff4d07ad.gif" alt="Package Example Overview"  align = "left">

#### Scrollable widget
```dart
ListView.separated(
  // General scroll controller which makes bridge between
  // This ListView and Hidable widget.
  controller: scrollController,
  itemCount: colors.length,
  itemBuilder: (_, i) => Container(
     height: 50,
     color: colors[i].withOpacity(.6),
  ),
  separatorBuilder: (_, __) => const SizedBox(height: 10),
),
```

#### Static located hidable widget
```dart
Hidable(
  controller: scrollController,
  wOpacity: true, // As default it's true.
  size: 56, // As default it's 56.
  child: BottomNavigationBar(...),
),
```
