import 'package:climb/main.dart';
import 'package:climb/views/Gym/Gyms.dart';
import 'package:climb/views/Gym/gym_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Widget page = const GymView();
    final appState = context.watch<AppState>();

    switch (appState.routeIndex) {
      case 0:
        page = const GymView();
        break;
      case 1:
        page = const GymDetail();
        break;
      default:
        throw UnimplementedError('no widget for ${appState.routeIndex}');
    }

    return Scaffold(
      key: const Key('home'),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: page,
      ),
    );
  }
}
