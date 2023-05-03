import 'package:climb/main.dart';
import 'package:climb/views/Session/components/session_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:climb/state/session_state.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final currentGymId = appState.currentGym?.id;

    return ChangeNotifierProvider(
      create: (context) => SessionState(currentGymId: currentGymId),
      child: Scaffold(
        key: const Key('sessions'),
        body: SessionList(currentGymId: currentGymId),
      ),
    );
  }
}
