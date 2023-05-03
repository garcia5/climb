import 'package:climb/main.dart';
import 'package:climb/state/gym_state.dart';
import 'package:climb/views/Gym/components/gym_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:climb/models/gym.dart';
import 'package:provider/provider.dart';

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
    final appState = context.watch<AppState>();
    final gymState = context.watch<GymState>();
    final gymDisplayTextTheme = Theme.of(context).textTheme.titleMedium;

    return GestureDetector(
      onLongPress: () {
        setState(() {
          isEditMode = true;
        });
      },
      onTap: () {
        appState.setCurrentGym(gym);
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.fitness_center),
            isEditMode
                ? GymEditForm(
                    gym: gym,
                    actionBtn: TextButton(
                      child: const Text('Save'),
                      onPressed: () {
                        gymState.updateGym(gym);
                        setState(() {
                          isEditMode = false;
                        });
                      },
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(gym.name, style: gymDisplayTextTheme),
                      Text(gym.address ?? '(No Address)',
                          style: gymDisplayTextTheme),
                    ],
                  ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                gym.delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
