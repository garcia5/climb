import 'package:flutter/material.dart';
import 'package:climb/models/gym.dart';

class GymCard extends StatefulWidget {
  const GymCard({super.key, required this.gym});

  final Gym gym;

  @override
  State<GymCard> createState() => _GymCardState();
}

class _GymCardState extends State<GymCard> {
  var isEditMode = false;
  late Gym gym;

  @override
  void initState() {
    super.initState();
    gym = widget.gym;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Icon(Icons.fitness_center),
          ),
          Center(
            child: Column(
              children: [
                Text(gym.name.toString()),
                Text(gym.address.toString()),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              gym.delete();
            },
          ),
        ],
      ),
    );
  }
}
