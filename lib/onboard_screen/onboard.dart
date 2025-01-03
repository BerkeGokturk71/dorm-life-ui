import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tester/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    buildPage(
                      "Yemek Planları",
                      "Yurtta çıkacak yemekleri kolayca öğrenin.",
                      "assets/animations/food.json",
                    ),
                    buildPage(
                      "Etkinlikler",
                      "Yurtta düzenlenecek etkinliklerden haberdar olun.",
                      "assets/animations/events.json",
                    ),
                    buildPage(
                      "Çamaşır Sırası",
                      "Çamaşır sırasını ve durumunu takip edin.",
                      "assets/animations/laundry.json",
                    ),
                  ],
                ),
              ),
              if (_currentPage == 2)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print("Onboarding Tamamlandı!");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: Text("Bitir"),
                    ),
                  ),
                ),
            ],
          ),
          if (_currentPage != 2)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Ekranı kaydırın",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildPage(String title, String description, String animationPath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animationPath, height: 250),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
