import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/api/test.dart';
import 'package:techarrow_mobile_final/auth/keycloak.dart';
import 'package:techarrow_mobile_final/main.dart';
import 'package:techarrow_mobile_final/screens/main/screen.dart';
import 'package:techarrow_mobile_final/screens/welcome/ui/logo.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final welcomes = [
    "Доброй ночи",
    "Доброе утро",
    "Добрый день",
    "Добрый вечер"
  ];

  String getWelcomePhrase() {
    int hour = DateTime.now().hour;
    if (hour < 4) {
      return welcomes[0];
    }
    if (hour < 12) {
      return welcomes[1];
    }
    if (hour < 16) {
      return welcomes[2];
    }
    return welcomes[3];
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1, milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
    Keycloak().isTokenExpired().then((value) => {
          value
              ? Keycloak().login().then((data) {
                  setState(() {
                    username = data.preferredUsername!;
                  });
                  Future.delayed(const Duration(seconds: 1), () {
                    // return;
                    navigateToMainScreen();
                  });
                })
              : Future.delayed(const Duration(seconds: 1), () {
                  // return;
                  navigateToMainScreen();
                })
        });
  }

  String? username;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToMainScreen() {
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              children: [
                const Spacer(),
                // RotatingImage(),
                Image.asset('assets/logo.png', width: 150),
                Text(
                  "${getWelcomePhrase()}${MainApp.username != "" ? ", ${MainApp.username}!" : "!"}",
                  style: TextStyle(fontSize: 24),
                ),
                const Spacer(flex: 2),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
