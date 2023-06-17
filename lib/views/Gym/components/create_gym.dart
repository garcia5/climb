import 'package:flutter/material.dart';
import 'package:climb/state/gym_state.dart';
import 'package:provider/provider.dart';

class CreateGym extends StatefulWidget {
  const CreateGym({super.key, this.expanded});

  final bool? expanded;

  @override
  State<CreateGym> createState() => _CreateGymState();
}

class _CreateGymState extends State<CreateGym> {
  String name = '';
  String? address;
  late bool expanded;

  @override
  void initState() {
    super.initState();
    expanded = (widget.expanded != null && widget.expanded!);
  }

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  void reset() {
    name = '';
    address = null;
    _nameController.clear();
    _addressController.clear();
    expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    var gymState = context.watch<GymState>();
    if (!expanded) {
      return IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          expanded = true;
        },
        tooltip: 'Add a Gym',
      );
    }
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
