import 'package:climb/models/gym.dart';
import 'package:climb/state/gym_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gym_card.dart';

class GymList extends StatefulWidget {
  const GymList({Key? key}) : super(key: key);

  @override
  State<GymList> createState() => _GymListState();
}

class _GymListState extends State<GymList> {
  final _key = GlobalKey();
  final gyms = <Gym>[];

  @override
  Widget build(BuildContext context) {
    final gymState = context.watch<GymState>();
    gymState.gymListKey = _key;

    return FutureBuilder<void>(
      future: gymState.getGyms(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (gymState.gyms.isEmpty) return const CircularProgressIndicator();
        return Expanded(
          flex: 3,
          child: ListView.builder(
            itemBuilder: (BuildContext itemCtx, int idx) {
              return GymCard(gym: gymState.gyms[idx]);
            },
            itemCount: gymState.gyms.length,
          ),
        );
      },
    );
  }
}
