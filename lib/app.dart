import 'package:flutter/material.dart';
import 'package:test_eds_app/ui/pages/test_isolate/home_page.dart';
import 'package:test_eds_app/ui/pages/test_platform_chanel/home_page.dart';

import 'ui/pages/user_pages/user_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
            opacity: 1,
            size: 20,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        primarySwatch: Colors.green,
      ),
      // home: const UsersListPage(),
      home: const HomePagePlatformChanelTest(),
    );
  }
}
