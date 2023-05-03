import 'package:climb/models/session.dart';
import 'package:flutter/material.dart';

class SessionState extends ChangeNotifier {
  SessionState({this.currentGymId});

  List<Session> sessions = [];
  int? currentGymId;
  GlobalKey? sessionListKey;

  Future<void> getSessions() async {
    sessions = await Session.list(gymId: currentGymId);
    notifyListeners();
  }

  Future<void> startSession({int? gymId}) async {
    if (currentGymId == null && gymId == null) {
      throw StateError('Must have gym set when creating session');
    }
    await Session.start((currentGymId ?? gymId)!);
    await getSessions();
  }

  Future<void> finishSession(Session session) async {
    await session.finish();
    await getSessions();
  }

  Future<void> deleteSession(Session session) async {
    await session.delete();
    await getSessions();
  }
}
