import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final colorsPath = [
    Colors.green,
    Colors.orangeAccent,
    Colors.orange,
    Colors.red
  ];

  int index = 0;

  // Create scroll controller that will be given to scrollable widget and hidable.
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// We've wrapped [AppBar] with [Hidable].
      /// So, now, our [AppBar] supports scroll to hide feature.
      appBar: Hidable(
        controller: scrollController,
        child: AppBar(
          backgroundColor: colorsPath[index].withOpacity(.6),
          title: const Text('Hidable'),
        ),
      ),

      /// Scrollable widget of main widget
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ListView.separated(
          /// scrollController should be given here, to scrollable widget.
          /// and same controller must to be given hidable.
          controller: scrollController,
          itemCount: 15,
          itemBuilder: (_, i) => _ListItem(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
        ),
      ),

      /// We've wrapped [BottomNavigationBar] with [Hidable].
      /// So, now, our [BottomNavigationBar] supports scroll to hide feature.
      bottomNavigationBar: Hidable(
        controller: scrollController,
        wOpacity: true, // As default it's true
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          items: bottomBarItems(),
        ),
      ),

      /// We've wrapped [FloatingActionButton] with [Hidable].
      /// So, now, our [FloatingActionButton] supports scroll to hide feature.
      floatingActionButton: Hidable(
        controller: scrollController,
        child: Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            child: const Icon(Icons.label),
            backgroundColor: colorsPath[index].withOpacity(.8),
            onPressed: () {
              // Do something ...
            },
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomBarItems() {
    return [
      BottomNavigationBarItem(
        label: 'Home',
        icon: const Icon(Icons.home, color: Colors.white),
        backgroundColor: colorsPath[0].withOpacity(.6),
      ),
      BottomNavigationBarItem(
        label: 'Favorites',
        icon: const Icon(Icons.favorite, color: Colors.white),
        backgroundColor: colorsPath[1].withOpacity(.6),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: const Icon(Icons.person, color: Colors.white),
        backgroundColor: colorsPath[2].withOpacity(.6),
      ),
      BottomNavigationBarItem(
        label: 'Settings',
        icon: const Icon(Icons.settings, color: Colors.white),
        backgroundColor: colorsPath[3].withOpacity(.6),
      ),
    ];
  }
}

class _ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.4),
        ),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Container(
              height: 15,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(.5),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      subtitle: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          children: [
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(.3),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
