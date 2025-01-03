import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase ile giriş yap
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = FirebaseAuth.instance.currentUser;
      final String? userName = user?.displayName;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google ile giriş başarılı!, $userName ")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google ile giriş başarısız: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const String googleLogin = 'Google ile Giriş Yap';
    const String login_text = 'Giriş Yap';
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Kullanıcı Adı',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Kullanıcı adı ve şifre ile giriş için yapılacaklar
                print('Kullanıcı Adı: ${_usernameController.text}');
                print('Şifre: ${_passwordController.text}');
              },
              child: const Text(login_text),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _signInWithGoogle,
              icon: const Icon(Icons.login),
              label: const Text(googleLogin),
            ),
          ],
        ),
      ),
    );
  }
}