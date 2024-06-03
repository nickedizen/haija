import 'package:final_project_haija/screens/sign_in_screen.dart';
import 'package:final_project_haija/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  _PengaturanScreen createState() => _PengaturanScreen();
}

class _PengaturanScreen extends State<PengaturanScreen> {
  bool _tema = false;
  

  @override
  void initState() {
    super.initState();

    _tema = false;
  }

  

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings),
            SizedBox(width: 8.0),
            const Text(
              'SETTINGS',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SwitchListTile(
                    title: const Text('Tema Gelap'),
                    value: _tema,
                    onChanged: (value) {
                      setState(() {
                        _tema = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70.0),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}