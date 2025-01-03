import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tester/cache/shared_cache.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final SharedManager _manager;
  List<String>? _cachedPassword;
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

  @override
  Widget build(BuildContext context) {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final headlineLarge =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Lottie.asset("assets/profile_lottie.json"),
                ),
              ),
              const SizedBox(height: 10),
              _cachedPassword?[1] == null
                  ? Text("")
                  : loginWelcomeText(_cachedPassword, context),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                        shape: StadiumBorder()),
                    child: Text(
                      "Edit Profile",
                      style: headlineLarge,
                      overflow: TextOverflow.visible,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey[450],
              ),
              SizedBox(height: 10),
              ProfileListIcons(
                  title: "Settings",
                  icon: Icon(Icons.manage_accounts_outlined)),
              ProfileListIcons(
                  title: "About", icon: Icon(Icons.article_outlined)),
              ProfileListIcons(
                  title: "Developer Daily ", icon: Icon(Icons.event_note)),
              ProfileListIcons(
                  title: "Version", icon: Icon(Icons.code_outlined)),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SocialLottieIcon(path: "assets/instagram_lottie.json"),
                      SocialLottieIcon(path: "assets/linkedin_lottie.json"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLottieIcon extends StatelessWidget {
  const SocialLottieIcon({
    super.key,
    required this.path,
  });
  final String path;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50, // Genişlik sınırı
        height: 50,
        child: Lottie.asset("$path"));
  }
}

class ProfileListIcons extends StatelessWidget {
  const ProfileListIcons({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.bodyMedium;
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.amberAccent.withOpacity(0.4)),
        child: IconButton(onPressed: () {}, icon: icon),
      ),
      title: Text(
        "$title",
        style: headlineSmall,
      ),
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_right_sharp,
            size: 30,
          )),
    );
  }
}

Text loginWelcomeText(List<String>? _cachedPassword, BuildContext context) =>
    Text("MERHABA  👋  ${_cachedPassword?[1]}",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white));
