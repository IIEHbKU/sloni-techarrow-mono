import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/screens/main/features/main_screen_features.dart';
import 'package:techarrow_mobile_final/screens/main/ui/month_page.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.toggleMenu, required this.isMenuOpened});

  final void Function() toggleMenu;
  final bool Function() isMenuOpened;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _features = MainScreenFeatures();

  late final TabController _tabbarController;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _offsetAnimationCalendar = Tween<Offset>(
      begin: Offset(0.0, -1), // Начальная позиция
      end: Offset(0.0, 0.0), // Конечная позиция
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimationPage = Tween<Offset>(
      begin: Offset(0.0, 0.0), // Начальная позиция
      end: Offset(0.0, 1.0), // Конечная позиция
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _animationIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _tabbarController =
        TabController(initialIndex: _page, length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabbarController.dispose();
    super.dispose();
  }

  void _toggleCalendar() {
    setState(() {
      if (_isCalendarOpened) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isCalendarOpened = !_isCalendarOpened;
    });
  }

  static int _page = 0;
  static bool _isCalendarOpened = false;

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimationCalendar;
  late Animation<Offset> _offsetAnimationPage;
  late Animation<double> _animationIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 0 && !widget.isMenuOpened()) {
          if (_isCalendarOpened) {
            _toggleCalendar();
          }
          widget.toggleMenu();
        }
        if (details.primaryDelta! < 0 && widget.isMenuOpened()) {
          widget.toggleMenu();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          forceMaterialTransparency: false,
          bottom: _isCalendarOpened
              ? null
              : TabBar(
                  controller: _tabbarController,
                  tabs: const [
                    Tab(
                      child: Text(
                        "День",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Неделя",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                  onTap: (value) {
                    setState(() {
                      _page = value;
                    });
                  },
                ),
          leading: !widget.isMenuOpened()
              ? IconButton(
                  onPressed: () {
                    if (_isCalendarOpened) {
                      _isCalendarOpened = !_isCalendarOpened;
                    }
                    widget.toggleMenu();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                  ))
              : null,
          centerTitle: true,
          title: Text("Ваши задачи"),
          actions: [
            IconButton(
              onPressed: _toggleCalendar,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: RotationTransition(
                turns: _animationIcon,
                child: Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Stack(
            children: [
              SlideTransition(
                position: _offsetAnimationCalendar,
                child: MonthPage(
                  isCalendarOpened: () => _isCalendarOpened,
                ),
              ),
              SlideTransition(
                position: _offsetAnimationPage,
                child: _features.pages[_tabbarController.index],
              ),
            ],
          ),
        ),
        floatingActionButton: _isCalendarOpened
            ? null
            : FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/add_task");
                },
                tooltip: "Создать новую задачу",
                child: Icon(Icons.add),
              ),
      ),
    );
  }
}
