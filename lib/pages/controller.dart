import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QueryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var gejalapilihan = ["G01", "G02", "G03", "G04", "G06"];
  final p01 = ["P01"];
  void filter() async {
    final results = await firestore
        .collection("aturan")
        .where(
          "kodegejala",
          whereIn: gejalapilihan,
        )
        .get();
    final jseluruhp = await firestore.collection("penyakit").get();

    if (results.docs.length > 0) {
      int jpeny = jseluruhp.docs.length;
      int test = results.docs.length;

      double proba = 1 / jpeny;
      print("Data yang ditemukan : $test");
      print("Probabilitas penyakit : $proba");

      results.docs.forEach((element) {
        var id = element.id;
        var data = element.data();
        var detabobot = data["bobot"];
        print(data);
      });
      if (proba > 0) {}
    } else {
      print("tidak ada");
    }
  }
}
