import 'package:climb/views/Gym/components/create_gym.dart';
import 'package:flutter/material.dart';

class NoGymsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.titleLarge!
        .copyWith(color: theme.colorScheme.onSecondaryContainer);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Card(
        color: theme.colorScheme.secondaryContainer,
        child: Column(
          children: [
            Text('Add a New Gym', style: titleTextStyle),
            const SizedBox(height: 10),
            const CreateGym(expanded: true),
          ],
        ),
      ),
    );
  }
}
