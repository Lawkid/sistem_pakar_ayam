import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataAturan extends StatefulWidget {
  const DataAturan({Key? key}) : super(key: key);

  @override
  _DataAturanState createState() => _DataAturanState();
}

class _DataAturanState extends State<DataAturan> {
  // text fields' controllers
  final TextEditingController _kodeaturanController = TextEditingController();
  final TextEditingController _kodepenyakitController = TextEditingController();
  final TextEditingController _kodegejalaController = TextEditingController();
  final TextEditingController _bobotController = TextEditingController();
  final CollectionReference _aturans =
      FirebaseFirestore.instance.collection('aturan');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _kodeaturanController.text = documentSnapshot['kodeaturan'];
      _kodepenyakitController.text = documentSnapshot['kodepenyakit'];
      _kodegejalaController.text = documentSnapshot['kodegejala'];
      _bobotController.text = documentSnapshot['bobot'].toString();
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
                  controller: _kodeaturanController,
                  decoration: const InputDecoration(labelText: 'Kode Aturan'),
                ),
                //pake dropdown
                TextField(
                  controller: _kodepenyakitController,
                  decoration: const InputDecoration(labelText: 'Kode Penyakit'),
                ),
                TextField(
                  controller: _kodegejalaController,
                  decoration: const InputDecoration(labelText: 'Kode Gejala'),
                ),
                //pake dropdown

                //pake dropdown

                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _bobotController,
                  decoration: const InputDecoration(
                    labelText: 'bobot',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? kodeaturan = _kodeaturanController.text;
                    final String? kodepenyakit = _kodepenyakitController.text;
                    final String? kodegejala = _kodegejalaController.text;
                    final String? bobot = _bobotController.text;
                    if (kodeaturan != null && kodepenyakit != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _aturans.add({
                          "kodeaturan": kodeaturan,
                          "kodepenyakit": kodepenyakit,
                          "kodegejala": kodegejala,
                          "bobot": bobot
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _aturans.doc(documentSnapshot!.id).update({
                          "kodeaturan": kodeaturan,
                          "kodepenyakit": kodepenyakit,
                          "kodegejala": kodegejala,
                          "bobot": bobot
                        });
                      }

                      // Clear the text fields
                      _kodeaturanController.text = '';
                      _kodepenyakitController.text = '';
                      _kodegejalaController.text = '';
                      _bobotController.text = '';

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
    await _aturans.doc(productId).delete();

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
        stream: _aturans.snapshots(),
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
                    title: Text(documentSnapshot['kodeaturan']),
                    subtitle: Text(documentSnapshot['bobot']),
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
