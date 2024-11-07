import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final sizebetweenElements = const SizedBox(
    width: 12,
    height: 12,
  );

  //Widget anzeige
  TextEditingController textSeconds = TextEditingController();
  TextEditingController textMinutes = TextEditingController();
  Color ScaffoldColor = Colors.transparent;

  //Counter Variablen
  final int clock = 50;
  int timerMS = 0;
  bool timerStarted = false;

  //Counter funktionen
  Future<void> startTimer() async {
    await Future.delayed(Duration(milliseconds: clock));
  }

  void formatTime(int timer) {
    textSeconds.text = ((timer / 1000) % 60).round().toString();
    textMinutes.text = ((timer / (1000 * 60)) % 60).toInt().toString();
  }

  Future<void> changeBackground() async {
    int index = 4;
    while (index > 0) {
      if (index % 2 == 0) {
        ScaffoldColor = Colors.blue;
      } else {
        ScaffoldColor = Colors.red;
      }

      if (mounted) {
        setState(() {
          ScaffoldColor;
        });
      }
      index--;
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (mounted) {
      setState(() {
        ScaffoldColor = Colors.transparent;
      });
    }
  }

  Future<void> count() async {
    int seconds = 0;
    int minutes = 0;

    if (textMinutes.text.contains(RegExp(r'[0-9]'))) {
      minutes = int.tryParse(textMinutes.text)!;
    } else {
      minutes = 0;
    }

    if (textSeconds.text.contains(RegExp(r'[0-9]'))) {
      seconds = int.tryParse(textSeconds.text)!;
    } else {
      seconds = 0;
    }

    timerMS = minutes * 60 * 1000 + seconds * 1000;

    while (timerStarted) {
      await startTimer();
      timerMS -= clock;
      if (timerMS <= 0) {
        timerStarted = false;
        timerMS = 0;
        changeBackground();
      }
      if (mounted) {
        setState(() {
          formatTime(timerMS);
        });
      }
    }
  }

  @override
  void dispose() {
    timerStarted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Timer")),
      ),
      backgroundColor: ScaffoldColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                  keyboardType: TextInputType.number,
                  controller: textMinutes,
                  onTap: () {
                    textMinutes.text = "";
                  },
                ),
              ),
              Text("m : ", style: Theme.of(context).textTheme.displayLarge),
              SizedBox(
                width: 120,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                  keyboardType: TextInputType.number,
                  controller: textSeconds,
                  onTap: () {
                    textSeconds.text = "";
                  },
                ),
              ),
              Text("s", style: Theme.of(context).textTheme.displayLarge),
            ],
          ),
          sizebetweenElements,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    timerStarted = true;
                    count();
                  },
                  child: const Text("Start")),
              ElevatedButton(
                  onPressed: () {
                    timerStarted = false;
                  },
                  child: const Text("Stopp")),
              ElevatedButton(
                  onPressed: timerStarted
                      ? null
                      : () {
                          setState(() {
                            textSeconds.text = "";
                            textMinutes.text = "";
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
