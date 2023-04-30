import 'package:climb/views/Gym/components/create_gym.dart';
import 'package:flutter/material.dart';
import 'package:climb/models/gym.dart';
import 'package:climb/views/Gym/components/gym_card.dart';

class GymView extends StatelessWidget {
  const GymView({super.key});

  Future<List<Gym>> getGyms() async {
    return await Gym.all();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key('gyms'),
        body: FutureBuilder<List<Gym>>(
            future: Gym.all(),
            builder: (BuildContext context, AsyncSnapshot<List<Gym>> snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              if (snapshot.data!.isEmpty) {
                return CreateGym();
              }
              return ListView.builder(
                itemBuilder: (BuildContext itemCtx, int idx) {
                  final gym = snapshot.data![idx];
                  return GymCard(gym: gym);
                },
                itemCount: snapshot.data!.length,
              );
            }));
  }
}
