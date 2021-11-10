import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamer_street/providers/tourney_provider.dart';
import 'package:provider/provider.dart';

class InTournamentDetails extends StatefulWidget {
  final tourneyId;
  const InTournamentDetails(this.tourneyId, {Key? key}) : super(key: key);

  @override
  State<InTournamentDetails> createState() => _InTournamentDetailsState();
}

class _InTournamentDetailsState extends State<InTournamentDetails> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TourneyProvider>(context, listen: false);
    return StreamBuilder(
        stream: provider.getRegisteredUsers(widget.tourneyId).asStream(),
        builder: (ctx, snapshot) {
          return ListView.builder(
              itemBuilder: (ctx, index) {
                return Text(snapshot.data.toString());
              },
              itemCount: 2);
        });
  }
}
