import 'package:climb/models/session.dart';
import 'package:climb/state/session_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionList extends StatefulWidget {
  const SessionList({super.key, this.currentGymId});
  final int? currentGymId;

  @override
  State<SessionList> createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  final _key = GlobalKey();
  final sessions = <Session>[];

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
    sessionState.sessionListKey = _key;

    return FutureBuilder<void>(
      future: sessionState.getSessions(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (sessionState.sessions.isNotEmpty)
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemBuilder: (BuildContext itemCtx, int idx) {
                    final session = sessionState.sessions[idx];
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                session.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                sessionState.deleteSession(session);
                              },
                            )
                          ],
                        )),
                      ),
                    );
                  },
                  itemCount: sessionState.sessions.length,
                ),
              ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: widget.currentGymId != null
                  ? () {
                      print('starting session at gym ${widget.currentGymId}');
                      sessionState.startSession(gymId: widget.currentGymId);
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
