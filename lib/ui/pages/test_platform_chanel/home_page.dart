import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePagePlatformChanelTest extends StatefulWidget {
  const HomePagePlatformChanelTest({Key? key}) : super(key: key);

  @override
  State<HomePagePlatformChanelTest> createState() =>
      _HomePagePlatformChanelTestState();
}

class _HomePagePlatformChanelTestState
    extends State<HomePagePlatformChanelTest> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_batteryLevel),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: _getBatteryLevel, child: Text("Press"))
        ],
      )),
    );
  }
}
