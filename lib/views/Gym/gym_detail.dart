import 'package:climb/main.dart';
import 'package:climb/views/Session/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './components/gym_title.dart';

class GymDetail extends StatefulWidget {
  const GymDetail({super.key});

  @override
  State<GymDetail> createState() => _GymDetailState();
}

class _GymDetailState extends State<GymDetail> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    if (appState.currentGym == null) {
      return const Text('No Gym Selected');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: IconButton(
            onPressed: () {
              appState.setRouteIndex(0);
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to All Gyms',
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: GymTitle(
                  name: appState.currentGym!.name,
                  address: appState.currentGym!.address,
                ),
              ),
              const SizedBox(height: 32),
              const Expanded(child: SessionView()),
            ],
          ),
        ),
      ],
    );
  }
}
