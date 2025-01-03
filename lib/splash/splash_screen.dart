import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tester/cache/shared_cache.dart';
import 'package:tester/login/login.dart';
import 'package:tester/onboard_screen/onboard.dart';
import '../home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AudioPlayer _audioPlayer;
  late final SharedManager _manager;

  @override
  void initState() {
    super.initState();
    _manager = SharedManager();
    _audioPlayer = AudioPlayer();
    _playSplashSound();
    // 4 saniye bekledikten sonra HomeScreen'e yönlendirme
    Future.delayed(const Duration(seconds: 4), () {
      if (_manager.getString(SharedKeys.counter) != null) {
        print(_manager.getString(SharedKeys.counter));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      } else {
        MaterialPageRoute(builder: (context) => LoginPageScreen());
      }
    });
  }

  Future<void> _playSplashSound() async {
    await _audioPlayer.play(AssetSource('normlifebebegim.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF86B9B2), Color(0xFF0E5D86)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max, // Tüm boşlukları kullanabilir.
            mainAxisAlignment: MainAxisAlignment.center, // Merkezde hizalama
            children: [
              Image.asset(
                'lib/assets/dorm.png', // PNG dosya yolu
                width: 450, // Daha makul bir genişlik
                height: 450, // Daha makul bir yükseklik
              ),
              Text(
                "Yurt Hayatınızı Kolaylaştırır...",
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
