<p align="center">
 <img width="500" src="https://user-images.githubusercontent.com/59066341/140976777-712cd333-9f82-4f92-8e03-33cb93f18650.png" alt="Package Logo">
 <br>
 <a href="https://pub.dev/packages/hidable">
  <img src="https://img.shields.io/pub/v/hidable?color=blue" alt="pub version" />
 </a>
 <a href="https://github.com/theiskaa/hidable/blob/main/LICENSE">
  <img src="https://img.shields.io/badge/License-Apache-red.svg" alt="License: MIT"/>
 </a>
 <br>
  <a href="https://discord.gg/CtStkzrHV3">
    <img src="https://img.shields.io/discord/914899238415130714?color=blue&label=Insolite Community&logo=discord"
      alt="Insolite Community Discord Invite Link" />
  </a>   
</p>

## Installing
**See the official installation guidelines at [hidable/install](https://pub.dev/packages/hidable/install)**
## Usage & Overview

<img width="300" src="https://user-images.githubusercontent.com/59066341/188278709-d9879bfe-b473-4b2c-b53b-6fbe97d35ad3.gif" alt="Package Example Overview">

To start using `Hidable` widget, we have to create a `ScrollController`. inctance before.
```dart
final ScrollController scrollController = ScrollController();
```
As case of usage, we should have one scrollable widget (SingleChildScrollView, ListView etc)
and one static located widget (`AppBar`, `BottomNavigationBar`, `FloatingActionButton` and etc) which would be wrapped with `Hidable` widget.

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
  enableOpacityAnimation: true, // optional, defaults to `true`.
  child: BottomNavigationBar(...),
),
```

**That is the common usage of hidable, and also you can find full code implmenetation of hidable at** [official example page](https://github.com/theiskaa/hidable/blob/main/example/main.dart).
