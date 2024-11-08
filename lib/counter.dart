import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final sizebetweenElements = const SizedBox(
    width: 12,
    height: 12,
  );

  //Widget anzeige
  int milliseconds = 0;
  int seconds = 0;
  int minutes = 0;

  //Counter Variablen
  final int clock = 10;
  int counterMS = 0;
  bool counterStarted = false;

  //Counter funktionen
  Future<void> startTimer() async {
    await Future.delayed(Duration(milliseconds: clock));
  }

  void formatTime(int counter) {
    milliseconds = counter % 1000;
    seconds = ((counter / 1000) % 60).toInt();
    minutes = ((counter / (1000 * 60)) % 60).toInt();
  }

  String formatMilliseconds(int milliseconds) {
    int formattedMilliseconds = (milliseconds ~/ 10) % 100;
    return formattedMilliseconds.toString().padLeft(2, '0');
  }

  Future<void> count() async {
    while (counterStarted) {
      await startTimer();
      counterMS += clock;
      if (mounted) {
        setState(() {
          formatTime(counterMS);
        });
      }
    }
  }

  @override
  void dispose() {
    counterStarted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$minutes", style: Theme.of(context).textTheme.displayLarge),
              Text(" : ", style: Theme.of(context).textTheme.displayLarge),
              Text("$seconds", style: Theme.of(context).textTheme.displayLarge),
              Text(" : ", style: Theme.of(context).textTheme.displayLarge),
              Text(formatMilliseconds(milliseconds),
                  style: Theme.of(context).textTheme.displayLarge),
            ],
          ),
          sizebetweenElements,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    print("Ich bin gestartet");
                    counterStarted = true;
                    count();
                  },
                  child: const Text("Start")),
              ElevatedButton(
                  onPressed: () {
                    counterStarted = false;
                  },
                  child: const Text("Stopp")),
              ElevatedButton(
                  onPressed: counterStarted
                      ? null
                      : () {
                          setState(() {
                            counterMS = 0;
                            formatTime(counterMS);
                          });
                        },
                  child: const Text("Clear")),
            ],
          )
        ],
      ),
    );
  }
}
