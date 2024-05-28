import 'package:flutter/material.dart';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  _PengaturanScreen createState() => _PengaturanScreen();
}

class _PengaturanScreen extends State<PengaturanScreen> {
  bool _tema = false;
  String _language = 'Indonesia';
  bool _meetUp = false;

  @override
  void initState() {
    super.initState();

    _tema = false;
    _language = 'Indonesia';
    _meetUp = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 20.0),
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
                const SizedBox(height: 70.0),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _language,
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'Indonesia',
                        child: Text('Indonesia'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'English',
                        child: Text('English'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _language = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 70.0),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SwitchListTile(
                    title: const Text('Izinkan Meetup'),
                    value: _meetUp,
                    onChanged: (value) {
                      setState(() {
                        _meetUp = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
