import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:techarrow_mobile_final/api/test.dart';
import 'package:techarrow_mobile_final/router/router.dart';
import 'package:techarrow_mobile_final/screens/welcome/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting("ru_RU");
  await dotenv.load(fileName: ".env");
  final String username =
      (await FlutterSecureStorage().read(key: "username")) ?? "";
  runApp(MainApp(
    username: username,
    initialRoute: '/welcome',
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.initialRoute, required String username}) {
    MainApp.username = username;
  }

  final String initialRoute;
  static String username = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
      routes: ApplicationRouter().routes,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      },
      // home: TestScreen(),
    );
  }
}
