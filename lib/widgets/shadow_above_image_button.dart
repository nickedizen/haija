import 'package:final_project_haija/screens/filtered_screen.dart';
import 'package:flutter/material.dart';

class ShadowAboveImageButton extends StatelessWidget {
  final String text;
  final String imageAsset;

  const ShadowAboveImageButton({super.key, required this.text, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              height: 100,
            ),

            Container(
                height: 100,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.black38
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    ),
                    backgroundBlendMode: BlendMode.multiply,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),

             Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),


            AnimatedContainer(
              duration: const Duration(seconds: 2),
              height: 100,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  // onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => FilteredScreen(genre: this.text))),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
              ),
            ),
          ],
        ),
      );
  }
}
