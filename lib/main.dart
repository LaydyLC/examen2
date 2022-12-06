import 'package:tres_en_raya/drawer/navigation_home_screen.dart';
import 'package:tres_en_raya/theme/AppTheme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: NavigationHomeScreen(),
    );
  }
}
