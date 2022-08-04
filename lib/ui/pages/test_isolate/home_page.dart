import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePageIsolateTest extends StatefulWidget {
  const HomePageIsolateTest({Key? key}) : super(key: key);

  @override
  State<HomePageIsolateTest> createState() => _HomePageIsolateTestState();
}

class _HomePageIsolateTestState extends State<HomePageIsolateTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                final i = await compute<IsolateModel, int>(
                        heavyTask, IsolateModel(355000, 500))
                    .then((value) => log("FINAL TOTAL: $value"));
              },
              child: Text("Press"))
        ],
      )),
    );
  }
}

class IsolateModel {
  IsolateModel(this.iteration, this.multiplier);

  final int iteration;
  final int multiplier;
}

int heavyTask(IsolateModel model) {
  int total = 0;

  /// Performs an iteration of the specified count
  for (int i = 1; i < model.iteration; i++) {
    /// Multiplies each index by the multiplier and computes the total
    total += (i * model.multiplier);
  }

  return total;
}
