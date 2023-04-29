import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var navIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    // switch (navIndex) {
    //   case 0:
    //     page = GeneratorPage();
    //     break;
    //   case 1:
    //     page = Placeholder();
    //     break;
    //   default:
    //     throw UnimplementedError('no widget for $selectedIndex');
    // }

    return Scaffold(
        key: const Key('home'),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: false,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Gyms'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bar_chart),
                    label: Text('Sessions'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: 0,
                onDestinationSelected: (value) {
                  setState(() {
                    navIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Landing(),
            )
          ],
        ));
  }
}

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [],
    ));
  }
}
