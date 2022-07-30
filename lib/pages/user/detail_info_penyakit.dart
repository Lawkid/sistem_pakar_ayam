import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPenyakit extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const DetailPenyakit({Key? key, required this.documentSnapshot})
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
          title: const Text("Detail Penyakit"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(height: 25),
              Text(
                documentSnapshot["namapenyakit"],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Text(
                "Deskripsi",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                documentSnapshot["deskripsi"],
              ),
              SizedBox(height: 20),
              Text(
                "Penanganan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                documentSnapshot["penanganan"],
              ),
              SizedBox(height: 20),
              Text(
                "Pencegahan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                documentSnapshot["pencegahan"],
              ),
            ],
          ),
        ));
  }
}
