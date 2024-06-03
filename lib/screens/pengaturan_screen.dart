import 'package:final_project_haija/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project_haija/screens/themeProvider.dart';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({Key? key}) : super(key: key);

  @override
  _PengaturanScreenState createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  bool _tema = false;

  @override
  void initState() {
    super.initState();
    _tema = Provider.of<Themeprovider>(context, listen: false).isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
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
            // Switch for Dark/Light Mode
            SwitchListTile(
              title: const Text('Tema Gelap'),
              value: _tema,
              onChanged: (value) {
                setState(() {
                  _tema = value;
                });
                Provider.of<Themeprovider>(context, listen: false).setTheme(value);
              },
            ),
            const SizedBox(height: 70.0),
            ElevatedButton(
              onPressed: () {
                    // Menavigasi ke layar logout (contoh: SignInScreen)
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
