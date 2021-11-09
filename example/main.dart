import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const MaterialApp(home: Example());
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final colors = [Colors.red, Colors.blue, Colors.yellow, Colors.green];

  int index = 0;

  // Create scroll controller that will be given to scrollable widget and hidable.
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Scrollable widget of main widget
      body: ListView.separated(
        /// scrollController should be given here, to scrollable widget.
        /// and same controller must to be given hidable.
        controller: scrollController,
        itemCount: 2 * colors.length,
        itemBuilder: (_, i) => Container(
          height: 100,
          color: [...colors, ...colors][i].withOpacity(.6),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),

      /// We've wrapped [BottomNavigationBar] with [Hidable].
      /// So now, our [BottomNavigationBar] is supports scroll to hide feature.
      bottomNavigationBar: Hidable(
        controller: scrollController,
        wOpacity: true, // As default it's true
        size: kBottomNavigationBarHeight, // As default it's same.
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          items: bottomBarItems(),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomBarItems() {
    return [
      BottomNavigationBarItem(
        label: 'Home',
        icon: const Icon(Icons.home, color: Colors.white),
        backgroundColor: colors[0].withOpacity(.9),
      ),
      BottomNavigationBarItem(
        label: 'Favorites',
        icon: const Icon(Icons.favorite, color: Colors.white),
        backgroundColor: colors[1].withOpacity(.9),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: const Icon(Icons.person, color: Colors.white),
        backgroundColor: colors[3].withOpacity(.9),
      ),
      BottomNavigationBarItem(
        label: 'Settings',
        icon: const Icon(Icons.settings, color: Colors.white),
        backgroundColor: colors[4].withOpacity(.9),
      ),
    ];
  }
}
