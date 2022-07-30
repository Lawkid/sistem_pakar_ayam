import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataGejala extends StatefulWidget {
  const DataGejala({Key? key}) : super(key: key);

  @override
  _DataGejalaState createState() => _DataGejalaState();
}

class _DataGejalaState extends State<DataGejala> {
  // text fields' controllers
  final TextEditingController _kodegejalaController = TextEditingController();
  final TextEditingController _namagejalaController = TextEditingController();

  final CollectionReference _gejalaa =
      FirebaseFirestore.instance.collection('gejala');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _kodegejalaController.text = documentSnapshot['kodegejala'];
      _namagejalaController.text = documentSnapshot['namagejala'];
      //klo berupa angka tambahkan.toString
      // _namagejalaController.text = documentSnapshot['namagejala'].toString();
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
                  controller: _kodegejalaController,
                  decoration: const InputDecoration(labelText: 'Kode Gejala'),
                ),
                TextField(
                  controller: _namagejalaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Gejala',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? kodegejala = _kodegejalaController.text;
                    final String? namagejala = _namagejalaController.text;
                    if (kodegejala != null && namagejala != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore

                        await _gejalaa.add({
                          "kodegejala": kodegejala,
                          "namagejala": namagejala,
                          "value": false,
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _gejalaa.doc(documentSnapshot!.id).update({
                          "kodegejala": kodegejala,
                          "namagejala": namagejala
                        });
                      }

                      // Clear the text fields
                      _kodegejalaController.text = '';
                      _namagejalaController.text = '';

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
    await _gejalaa.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Data Gejala'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _gejalaa.snapshots(),
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
                    title: Text(documentSnapshot['namagejala']),
                    subtitle: Text(documentSnapshot['kodegejala']),
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
