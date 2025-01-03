import 'package:flutter/material.dart';
import 'package:tester/camasir.dart';
import 'package:tester/food__list.dart';
import 'package:tester/login/login.dart';
import 'package:tester/machine/machine_loan.dart';
import 'package:tester/profile/profile_page.dart';
import 'cache/shared_cache.dart';
import 'google_auth.dart';

//ss
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final SharedManager _manager;
  List<String>? _cachedPassword;
  final List<Widget> _pages = [
    Center(child: AnaEkran()),
    MachineLoan(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _manager = SharedManager();
    _loadCachedPassword();
  }

  Future<void> _loadCachedPassword() async {
    await _manager.init(); // SharedPreferences başlat
    List<String>? cachedData = await _manager.getStringList(SharedKeys.counter);

    setState(() {
      _cachedPassword = cachedData;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNotificationsPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bildirimler'),
          content: Text('Henüz yeni bir bildirim yok!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String>? _cachedPassword = _manager.getStringList(SharedKeys.counter);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // AppBar gölgesini kaldırmak için
        title: const Text(
          textAlign: TextAlign.start,
          'DormLife',
          style: TextStyle(
            fontSize: 25, // Daha büyük font boyutu
            fontWeight: FontWeight.w200, // Kalın yazı
            color: Colors.white,
            letterSpacing: 2, // Harf aralığı
          ),
        ),
        actions: [
          _cachedPassword?[1] == null
              ? loginButton()
              : loginWelcomeText(_cachedPassword),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: _onNotificationsPressed,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _pages[_selectedIndex], // Seçilen ekranı gösterir
          ),
          // Alt Bar
          SizedBox(
            height: 60,
            child: BottomNavigationBar(
              backgroundColor: Colors.white10,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu), // Yemek ikonu
                  label: 'Yemekler',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event), // Etkinlikler ikonu
                  label: 'Çamaşır',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person), // Hesap ikonu
                  label: 'Hesabım',
                ),
              ],
              currentIndex: _selectedIndex, // Seçili olan butonu belirler
              selectedItemColor: Colors.white, // Seçili olan butonun rengi
              unselectedItemColor:
                  Colors.white10, // Seçili olmayan butonların rengi
              onTap: _onItemTapped, // Butona tıklanınca çağrılır
              elevation: 0, // Alt barın gölgesini kaldırır
            ),
          ),
        ],
      ),
    );
  }

  Text loginWelcomeText(List<String>? _cachedPassword) =>
      Text("Hoşgeldiniz ${_cachedPassword?[1]}");

  OutlinedButton loginButton() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white), // Kenar çizgisi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPageScreen()),
          (Route<dynamic> route) => false,
        );
      },
      icon: Icon(Icons.login, color: Colors.white),
      label: Text(
        "Giriş Yap",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
