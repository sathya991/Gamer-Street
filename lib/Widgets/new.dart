import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class New extends StatefulWidget {
  final String id;
  const New({Key? key, required this.id}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  Future<QuerySnapshot> get() {
    print(widget.id);
    String id = widget.id;
    return FirebaseFirestore.instance
        .collection('tournaments')
        .doc(widget.id)
        .collection('basicInfo')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: get(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        } else {
          var data = snap.data!.docs.isEmpty;
          return Text(data.toString());
        }
      },
    );
  }
}
