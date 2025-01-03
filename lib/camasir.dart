import 'package:flutter/material.dart';

class CamasirScreen extends StatefulWidget {
  const CamasirScreen({super.key});

  @override
  State<CamasirScreen> createState() => _CamasirScreenState();
}

class _CamasirScreenState extends State<CamasirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center the content vertically and horizontally
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Vertically center the text
            children: [
              Text("Bu Ekran Yapım Aşamasındadır"),
              Text("Çamaşır Sırası Hizmetimiz Üzerinde Çalışıyoruz")
            ],
          ),
        ),
      ),
    );
  }
}
