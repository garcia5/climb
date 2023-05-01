import 'package:climb/models/gym.dart';
import 'package:flutter/material.dart';

class GymEditForm extends StatefulWidget {
  GymEditForm({super.key, required this.gym, this.actionBtn});

  Gym gym;
  Widget? actionBtn;

  @override
  State<GymEditForm> createState() => _GymEditFormState();
}

class _GymEditFormState extends State<GymEditForm> {
  late TextEditingController _gymNameController;
  late TextEditingController _gymAddressController;

  @override
  void initState() {
    super.initState();
    _gymNameController = TextEditingController(text: widget.gym.name);
    _gymAddressController =
        TextEditingController(text: widget.gym.address ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputDecorator(
            decoration: const InputDecoration(label: Text('Gym Name')),
            child: TextField(
              controller: _gymNameController,
              onChanged: (value) => widget.gym.name = value,
            ),
          ),
          InputDecorator(
            decoration: const InputDecoration(
              label: Text('Gym Address'),
            ),
            child: TextField(
              controller: _gymAddressController,
              onChanged: (value) => widget.gym.address = value,
            ),
          ),
          if (widget.actionBtn != null) widget.actionBtn!,
        ],
      ),
    );
  }
}
