// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pakar_ayam/pages/admin/data_aturan.dart';
import 'package:sistem_pakar_ayam/pages/admin/data_gejala.dart';
import 'package:sistem_pakar_ayam/pages/admin/data_penyakit.dart';

class HomeAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text(
                  'Sistem Pakar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  'Diagnosa Penyakit Pada Ayam Broiler',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size(0.0, 80.0),
        ),
        toolbarHeight: 100,
        flexibleSpace: Image(
          image: AssetImage('assets/logotest.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: MenuAdmin(),
    );
  }
}

//Menu Admun
class MenuAdmin extends StatelessWidget {
  const MenuAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataPenyakit(),
                    ),
                  );
                },
                child: CardMenu(Icons.vaccines_rounded, "Data Penyakit"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataGejala(),
                    ),
                  );
                },
                child: CardMenu(Icons.list_rounded, "Data Gejala"),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataAturan(),
                    ),
                  );
                },
                child: CardMenu(Icons.settings, "Data Aturan"),
              ),
              InkWell(
                onTap: () => FirebaseAuth.instance.signOut(),
                child: CardMenu(Icons.logout_rounded, "Keluar"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container CardMenu(IconData iconData, String text) {
    return Container(
      width: 165,
      height: 165,
      child: Card(
        color: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(
                iconData,
                size: 70,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
