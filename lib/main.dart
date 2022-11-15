import 'package:flutter/material.dart';
import 'package:flutter_state_management/feature/onboard/on_board_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const OnBoardView(),
      theme: ThemeData.light().copyWith(floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.indigo.shade500)),
    );
  }
}
