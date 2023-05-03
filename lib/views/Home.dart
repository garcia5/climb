import 'package:climb/views/Gym/Gyms.dart';
import 'package:climb/views/Session/session.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var navIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page = const GymView();

    switch (navIndex) {
      case 0:
        page = const GymView();
        break;
      case 1:
        page = const SessionView();
        break;
      default:
        throw UnimplementedError('no widget for $navIndex');
    }

    return Scaffold(
        key: const Key('home'),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: false,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.fitness_center),
                    label: Text('Gyms'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bar_chart),
                    label: Text('Sessions'),
                  ),
                ],
                selectedIndex: navIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    navIndex = value;
                  });
                },
              ),
            ),
            Expanded(child: page),
          ],
        ));
  }
}
