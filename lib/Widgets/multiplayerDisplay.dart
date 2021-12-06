import 'package:flutter/material.dart';
import 'package:gamer_street/screens/profile.dart';

class MultiPlayerDisplay extends StatefulWidget {
  final snapshot;
  final isHost;
  const MultiPlayerDisplay({this.snapshot, this.isHost, Key? key})
      : super(key: key);

  @override
  _MultiPlayerDisplayState createState() => _MultiPlayerDisplayState();
}

class _MultiPlayerDisplayState extends State<MultiPlayerDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.snapshot.data!.docs.length,
        itemBuilder: (ctx, index) {
          var val = widget.snapshot.data!.docs;
          Map valMap = val[index].get('players');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: valMap['email'].length,
                itemBuilder: (ctx1, index1) {
                  return GestureDetector(
                    key: ValueKey(valMap['userName'][index1]),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: valMap['profileUrl'][index]
                                    .toString()
                                    .isEmpty
                                ? NetworkImage(
                                    "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png")
                                : NetworkImage(valMap['profileUrl'][index]),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(valMap['userName'][index1])
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(Profile.profile,
                          arguments: valMap['playerDocId'][index]);
                    },
                  );
                }),
          );
        });
  }
}
