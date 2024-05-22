import 'package:flutter/material.dart';
import 'package:final_project_haijo/screens/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/sampul.jpg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black45, BlendMode.darken),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0.0, -100),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage("images/logo.png")),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: const Text(
                      "Read more and stress less with our online book shopping app. Shop from anywhere you are and discover that you love. Happy reading!",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
