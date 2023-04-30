import 'package:climb/models/gym.dart';
import 'package:flutter/material.dart';

class GymState extends ChangeNotifier {
  List<Gym> gyms = [];
  GlobalKey? gymListKey;

  Future<void> getGyms() async {
    gyms = await Gym.all();
    notifyListeners();
  }

  Future<void> updateGym(Gym gym) async {
    gym.save();
    await getGyms();
  }

  Future<void> createGym(String name, String? address) async {
    await Gym.create(name, address);
    await getGyms();
  }
}
