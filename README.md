<p align="center">
 <img width="500" src="https://user-images.githubusercontent.com/59066341/140976777-712cd333-9f82-4f92-8e03-33cb93f18650.png" alt="Package Logo">
 <br>
 <a href="https://pub.dev/packages/hidable">
  <img src="https://img.shields.io/pub/v/hidable?color=blue" alt="pub version" />
 </a>
 <a href="https://github.com/theiskaa/hidable/blob/main/LICENSE">
  <img src="https://img.shields.io/badge/License-Apache-red.svg" alt="License: MIT"/>
 </a>
</p>

## Installing
**See the official installing guidline from [hidable/install](https://pub.dev/packages/hidable/install)**
## Usage & Overview

<img width="300" src="https://user-images.githubusercontent.com/59066341/140974710-bfd27779-be3e-4068-aa80-46b2ff4d07ad.gif" alt="Package Example Overview">

To start using `Hidable` widget, we have to create a `ScrollController`. inctance before.
```dart
final ScrollController scrollController = ScrollController();
```
As case of usage, we should have one scrollable widget (SingleChildScrollView, ListView etc)
and one static located widget (AppBar, BottomNavBar etc) which'd be wrapped with `Hidable` widget.

So, `scrollController` which we created before must be given to each one (scrollable widget and static located hidable widget).

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

**That is the common usage of hidable, and also you can find full code implmenetation of hidable at** [official example page](https://github.com/theiskaa/hidable/blob/main/example/main.dart).
