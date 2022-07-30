import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HasilDiagnosa extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const HasilDiagnosa({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_rounded),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text("Hasil Diagnosa"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                documentSnapshot["kodegejala"],
              )
            ],
          ),
        ));
  }
}
