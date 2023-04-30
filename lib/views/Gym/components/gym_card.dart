import 'package:flutter/material.dart';
import 'package:climb/models/gym.dart';

class GymCard extends StatefulWidget {
  const GymCard({super.key, required this.gym});

  final Gym gym;

  @override
  State<GymCard> createState() => _GymCardState(gym: gym);
}

class _GymCardState extends State<GymCard> {
  _GymCardState({required this.gym});

  Gym gym;
  var isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Column(children: const [Icon(Icons.fitness_center)])),
        Center(
            child: Column(
          children: [Text(gym.name.toString()), Text(gym.address.toString())],
        )),
      ],
    ));
  }
}
