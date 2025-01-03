import 'package:flutter/material.dart';
import 'package:tester/cache/shared_cache.dart';
import 'package:tester/home_screen.dart';
import 'package:tester/model/login_post_model.dart';
import 'package:tester/service/login_api_service.dart';

class MyButton extends StatefulWidget {
  final TextEditingController userController;
  final TextEditingController passwordController;

  const MyButton({
    Key? key,
    required this.userController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late final SharedManager _manager;
  late final LoginService _login;
  @override
  void initState() {
    super.initState();
    _manager = SharedManager();
    _login = LoginService();
  }

  final loginData = LoginModel();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String username = widget.userController.text;
        String password = widget.passwordController.text;
        bool _isLoading = true;

        loginData.username = username;
        loginData.password = password;
        _login.loginItem(loginData).then((value) async {
          if (value != null && value.password != null) {
            print("data value $value");
            await _manager.saveStringList(SharedKeys.counter,
                <String>["${value.username}", "${value.password}"]);
            snackBarLoginTrue(context);

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            dialogError(context);
          }
        });

        //_manager.saveString(SharedKeys.counter, value.)
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(horizontal: 35.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Center(
          child: Text(
            "Giriş Yap",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      snackBarLoginTrue(BuildContext context) async {
    final cachePassword = _manager.getStringList(SharedKeys.counter);
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Giriş Başarılı ${cachePassword?[1]}"),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating, // Mesajı yukarıda göstermek için
        duration: Duration(seconds: 3), // Görüntüleme süresi
      ),
    );
  }

  Future<dynamic> dialogError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hata"),
          content: Text("Kullanıcı adınız veya şifreniz yanlış."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pop-up'ı kapatır
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}

void _isLoading(bool _isLoading) {
  _isLoading != _isLoading;
}
