// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistem_pakar_ayam/pages/admin/login_screen.dart';
import 'package:sistem_pakar_ayam/pages/user/diagnosa_screen.dart';
import 'package:sistem_pakar_ayam/pages/user/info_penyakit.dart';
import 'package:sistem_pakar_ayam/pages/user/testhitung.dart';

class HomeUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(0.0, 80.0),
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
        ),
        toolbarHeight: 100,
        flexibleSpace: Image(
          image: AssetImage('assets/ayam.jpeg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: MenuUser(),
    );
  }
}

class MenuUser extends StatelessWidget {
  const MenuUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
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
                          builder: (context) => DiagnosaPenyakit(),
                        ),
                      );
                    },
                    child: CardMenu(Icons.search_rounded, "Diagnosa Penyakit"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoPenyakit(),
                        ),
                      );
                    },
                    child: CardMenu(Icons.list_rounded, "Info Penyakit"),
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
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: CardMenu(Icons.login_rounded, "Login"),
                  ),
                  InkWell(
                    onTap: () {
                      SystemNavigator.pop();
                    },
                    child: CardMenu(Icons.logout_rounded, "Keluar"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestHitung(),
                        ),
                      );
                    },
                    child: CardMenu(Icons.login_rounded, "Tesr"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container CardMenu(IconData iconData, String text) {
    // ignore: sized_box_for_whitespace
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
