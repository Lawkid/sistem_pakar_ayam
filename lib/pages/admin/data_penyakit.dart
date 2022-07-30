import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataPenyakit extends StatefulWidget {
  const DataPenyakit({Key? key}) : super(key: key);

  @override
  _DataPenyakitState createState() => _DataPenyakitState();
}

class _DataPenyakitState extends State<DataPenyakit> {
  // text fields' controllers
  final TextEditingController _kodepenyakitController = TextEditingController();
  final TextEditingController _namapenyakitController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _penangananController = TextEditingController();
  final TextEditingController _pencegahanController = TextEditingController();

  final CollectionReference _penyakits =
      FirebaseFirestore.instance.collection('penyakit');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _kodepenyakitController.text = documentSnapshot['kodepenyakit'];
      _namapenyakitController.text = documentSnapshot['namapenyakit'];
      _deskripsiController.text = documentSnapshot['deskripsi'];
      _penangananController.text = documentSnapshot['penanganan'];
      _pencegahanController.text = documentSnapshot['pencegahan'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _kodepenyakitController,
                  decoration: const InputDecoration(labelText: 'Kode Penyakit'),
                ),
                TextField(
                  controller: _namapenyakitController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Penyakit',
                  ),
                ),
                TextField(
                  controller: _deskripsiController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                  ),
                ),
                TextField(
                  controller: _penangananController,
                  decoration: const InputDecoration(
                    labelText: 'Penaganan',
                  ),
                ),
                TextField(
                  controller: _pencegahanController,
                  decoration: const InputDecoration(
                    labelText: 'Pencegahan',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? kodepenyakit = _kodepenyakitController.text;
                    final String? namapenyakit = _namapenyakitController.text;
                    final String? deskripsi = _deskripsiController.text;
                    final String? penanganan = _penangananController.text;
                    final String? pencegahan = _pencegahanController.text;
                    if (kodepenyakit != null && namapenyakit != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _penyakits.add({
                          "kodepenyakit": kodepenyakit,
                          "namapenyakit": namapenyakit,
                          "deskripsi": deskripsi,
                          "penanganan": penanganan,
                          "pencegahan": pencegahan,
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _penyakits.doc(documentSnapshot!.id).update({
                          "kodepenyakit": kodepenyakit,
                          "namapenyakit": namapenyakit,
                          "deskripsi": deskripsi,
                          "penanganan": penanganan,
                          "pencegahan": pencegahan,
                        });
                      }

                      // Clear the text fields
                      _kodepenyakitController.text = '';
                      _namapenyakitController.text = '';
                      _deskripsiController.text = '';
                      _penangananController.text = '';
                      _deskripsiController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _penyakits.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Data Penyakit'),
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
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
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
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
