import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailPenulisScreen extends StatefulWidget {
  const DetailPenulisScreen({super.key});

  @override
  _DetailPenulisScreen createState() => _DetailPenulisScreen();
}

class _DetailPenulisScreen extends State<DetailPenulisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Oscar Wilde',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Author of 10 books',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'dhckasnkandsoiasncksanoiancjnasjonfancnsdcnlsndcfoiaijpandkanskcnaijcianfkdanfiaksfnaiddiaskanaidnaifianckansifaifkanspiajsifiadhckasnkandsoiasncksanoiancjnasjonfancnsdcnlsndcfoiaijpandkanskcnaijcianfkdanfiaksfnaiddiaskanaidnaifianckansifaifkanspiajsifia',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Read More'),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '10 BOOKS BY OSCAR WILDE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(''),
                    title: const Text('The Picture of Dorian Gray'),
                    subtitle: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star_half,
                                color: Colors.amber, size: 16),
                            SizedBox(width: 8),
                            Text('4.11/5'),
                          ],
                        ),
                        Text('120 ratings'),
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.pink, size: 16),
                            SizedBox(width: 4),
                            Text('Loved by 405 users'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
