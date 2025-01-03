import 'package:flutter/material.dart';
import 'package:tester/login/components/mybutton.dart';
import 'package:tester/login/components/textfield.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final bool obsecureText = true;
    const String welcomeLogin =
        "Hoşgeldiniz Bu Alandan Giriş Yaparak Aramıza Katılabilirsiniz";
    const hintTextUsername = "Kullanıcı Adınız";
    const hintTextPassword = 'Şifre';

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.supervised_user_circle_sharp, size: 100),
                  const SizedBox(height: 50.0),
                  const Text(welcomeLogin),
                  const SizedBox(height: 40.0),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldArea(
                            controller: userController,
                            hintText: hintTextUsername,
                            obsecureText: !obsecureText,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFieldArea(
                            controller: passwordController,
                            hintText: hintTextPassword,
                            obsecureText: obsecureText,
                          ),
                          SizedBox(height: 20.0),
                          MyButton(
                            userController: userController,
                            passwordController: passwordController,
                          ),
                          SizedBox(height: 40.0),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Yada Devam Edin",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.login),
                                label: const Text("googleLogin"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
