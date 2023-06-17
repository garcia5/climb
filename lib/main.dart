import 'package:climb/models/session.dart';
import 'package:climb/views/Home.dart';
import 'package:climb/models/gym.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'My Climbs',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: const Home(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  Gym? currentGym;
  Session? currentSession;
  int routeIndex = 0;

  void setRouteIndex(int idx) {
    routeIndex = idx;
    notifyListeners();
  }

  void setCurrentGym(Gym gym) {
    currentGym = gym;
    notifyListeners();
  }

  void setActiveSession(Session session) {
    currentSession = session;
    notifyListeners();
  }
}
