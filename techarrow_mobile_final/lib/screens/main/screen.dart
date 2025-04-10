import 'package:anim_side_menu/anim_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/auth/keycloak.dart';
import 'package:techarrow_mobile_final/screens/main/features/main_screen_features.dart';
import 'package:techarrow_mobile_final/screens/pomodoro/screen.dart';
import 'package:techarrow_mobile_final/screens/main/ui/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  final _features = MainScreenFeatures();

  toggleMenu() {
    setState(() {
      if (isMenuOpened()) {
        _sideMenuKey.currentState!.closeSideMenu();
      } else {
        _sideMenuKey.currentState!.openSideMenu();
      }
    });
  }

  bool isMenuOpened() => _sideMenuKey.currentState!.isOpened;

  Future<ApplicationUserInfo> data =
      Future.value(ApplicationUserInfo(id: "", username: ""));

  @override
  void initState() {
    data = _features.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        key: _sideMenuKey,
        type: SideMenuType.slide,
        onClosedIcon: () {
          toggleMenu();
        },
        background: Theme.of(context).primaryColor,
        menu: buildMenu(),
        closeIcon: const Icon(
          Icons.close_rounded,
          size: 30.0,
          color: Colors.white,
        ),
        animatedDuration: const Duration(milliseconds: 1500),
        child: HomePage(
          toggleMenu: toggleMenu,
          isMenuOpened: isMenuOpened,
        ));
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            textColor: Colors.white,
            title: FutureBuilder(
              builder: (context, snapshot) {
                String name;
                if (snapshot.hasData) {
                  name = snapshot.data!.username;
                } else {
                  name = "дорогой пользователь";
                }
                return Text(
                  'Привет, $name!',
                  style: TextStyle(fontSize: 22),
                );
              },
              future: data,
            ),
          ),
          Divider(),
          ListTile(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pushNamed('/tasks');
            },
            leading: const Icon(Icons.task, size: 30.0, color: Colors.white),
            title: const Text(
              "Список задач",
              style: TextStyle(fontSize: 22),
            ),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pushNamed('/advices');
            },
            leading: const Icon(Icons.info, size: 30.0, color: Colors.white),
            title: const Text(
              "Советы",
              style: TextStyle(fontSize: 22),
            ),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pushNamed('/pomodoro',
                  arguments: PomodoroScreenArguments(
                      taskName: "Таймер Pomodoro", taskId: ""));
            },
            leading: const Icon(Icons.timer, size: 30.0, color: Colors.white),
            title: const Text(
              "Pomodoro",
              style: TextStyle(fontSize: 22),
            ),
            textColor: Colors.white,
            dense: true,
          ),
          Divider(),
          ListTile(
            onTap: () => _features.logout().then(
              (value) {
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed('/welcome');
                }
              },
            ),
            leading: const Icon(Icons.logout, size: 30.0, color: Colors.white),
            title: const Text(
              "Выйти",
              style: TextStyle(fontSize: 22),
            ),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
