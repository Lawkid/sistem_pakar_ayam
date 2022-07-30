import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pakar_ayam/pages/user/hasildiagnosa_screen.dart';

class DiagnosaPenyakit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> gejala =
        FirebaseFirestore.instance.collection('gejala').snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text("Diagnosa Penyakit"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: gejala,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return CheckboxListTile(
                title: Text(data['namagejala']),
                value: data['value'],
                onChanged: (bool? value) {
                  FirebaseFirestore.instance
                      .collection('gejala')
                      .doc(document.id)
                      .update({'value': value!});
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Diagnosa Penyakit'),
        icon: const Icon(Icons.search_rounded),
        onPressed: () {
          //tambah fungsi button untuk mendiagnosa penyakit
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
