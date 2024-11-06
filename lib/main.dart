import 'package:flutter/material.dart';
import 'package:ts_5_2_1_stoppuhr/themes/light_theme.dart';

void main() {
  runApp(const MainApp());
}

const sizebetweenElements = SizedBox(
  width: 12,
  height: 12,
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stoppuhr",
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Stoppuhr"),
          //foregroundColor: Theme.of(context).colorScheme.onPrimary,
          //backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "12",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                sizebetweenElements,
                Text("s", style: Theme.of(context).textTheme.displayLarge)
              ],
            ),
            sizebetweenElements,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(Theme.of(context).textTheme.displayLarge);
                    },
                    child: const Text("Start")),
                ElevatedButton(onPressed: () {}, child: const Text("Stopp")),
                ElevatedButton(onPressed: () {}, child: const Text("Clear")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
