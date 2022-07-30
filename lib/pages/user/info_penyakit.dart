import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pakar_ayam/pages/user/detail_info_penyakit.dart';

class InfoPenyakit extends StatefulWidget {
  const InfoPenyakit({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InfoPenyakitState createState() => _InfoPenyakitState();
}

class _InfoPenyakitState extends State<InfoPenyakit> {
  final CollectionReference _penyakits =
      FirebaseFirestore.instance.collection('penyakit');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Penyakit'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _penyakits.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['namapenyakit']),
                    subtitle: Text(documentSnapshot['kodepenyakit']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPenyakit(
                                documentSnapshot: documentSnapshot)),
                      );
                    },
                    trailing: SizedBox(
                      width: 100,
                      child: Row(),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
