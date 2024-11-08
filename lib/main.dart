import 'package:flutter/material.dart';
import 'package:ts_5_2_1_stoppuhr/counter.dart';
import 'package:ts_5_2_1_stoppuhr/themes/light_theme.dart';
import 'package:ts_5_2_1_stoppuhr/timer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Widget> _screens = [const Timer(), const Counter()];
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  void setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stoppuhr",
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Timer & Counter")),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: toggleTheme,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
            BottomNavigationBarItem(icon: Icon(Icons.watch), label: "Stoppuhr"),
          ],
          currentIndex: _selectedIndex,
          onTap: setScreen,
        ),
        body: _screens[_selectedIndex],
      ),
    );
  }
}
