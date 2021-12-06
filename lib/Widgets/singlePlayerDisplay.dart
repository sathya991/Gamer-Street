import 'package:flutter/material.dart';
import 'package:gamer_street/screens/profile.dart';

class SinglePlayerDisplay extends StatefulWidget {
  final snapshot;
  final isHost;
  const SinglePlayerDisplay({this.snapshot, this.isHost, Key? key})
      : super(key: key);

  @override
  _SinglePlayerDisplayState createState() => _SinglePlayerDisplayState();
}

class _SinglePlayerDisplayState extends State<SinglePlayerDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.snapshot.data!.docs.length,
        itemBuilder: (ctx, index) {
          var val = widget.snapshot.data!.docs;
          Map valMap = val[index].get('players');
          return GestureDetector(
            key: ValueKey(val[index].id),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: valMap['profileUrl'][0].toString().isEmpty
                        ? NetworkImage(
                            "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png")
                        : NetworkImage(valMap['profileUrl'][0]),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(valMap['userName'][0])
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Profile.profile,
                  arguments: valMap['playerDocId'][0]);
            },
          );
        });
  }
}
