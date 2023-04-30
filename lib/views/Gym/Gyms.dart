import 'package:flutter/material.dart';
import 'package:climb/models/gym.dart';
import 'package:climb/views/Gym/components/gym_card_list.dart';
import 'package:provider/provider.dart';
import 'package:climb/state/gym_state.dart';

class GymView extends StatelessWidget {
  const GymView({super.key});

  Future<List<Gym>> getGyms() async {
    return await Gym.all();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GymState(),
      child: const Scaffold(
        key: Key('gyms'),
        body: GymList(),
      ),
    );
  }
}
