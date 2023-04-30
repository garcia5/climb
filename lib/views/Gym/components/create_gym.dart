import 'package:flutter/material.dart';
import 'package:climb/models/gym.dart';

class CreateGym extends StatefulWidget {
  const CreateGym({super.key});

  @override
  State<CreateGym> createState() => _CreateGymState();
}

class _CreateGymState extends State<CreateGym> {
  String name = '';
  String? address;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(children: [
          InputDecorator(
            decoration: const InputDecoration(label: Text('Gym Name')),
            child: TextField(onChanged: (value) => name = value),
          ),
          InputDecorator(
            decoration: const InputDecoration(label: Text('Gym Address')),
            child: TextField(onChanged: (value) => address = value),
          ),
        ]),
      ),
    );
  }
}
