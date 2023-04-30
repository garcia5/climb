import 'package:flutter/material.dart';
import 'package:climb/state/gym_state.dart';
import 'package:provider/provider.dart';

class CreateGym extends StatefulWidget {
  const CreateGym({super.key});

  @override
  State<CreateGym> createState() => _CreateGymState();
}

class _CreateGymState extends State<CreateGym> {
  String name = '';
  String? address;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  void reset() {
    name = '';
    address = null;
    _nameController.clear();
    _addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var gymState = context.watch<GymState>();
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputDecorator(
                decoration: const InputDecoration(label: Text('Gym Name')),
                child: TextField(
                    controller: _nameController,
                    onChanged: (value) => name = value),
              ),
              InputDecorator(
                decoration: const InputDecoration(
                  label: Text('Gym Address'),
                ),
                child: TextField(
                    controller: _addressController,
                    onChanged: (value) => address = value),
              ),
              TextButton(
                child: const Text('Create'),
                onPressed: () {
                  gymState.createGym(name, address);
                  reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
