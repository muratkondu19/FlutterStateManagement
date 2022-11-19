import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_management/feature/login/view/login_view.dart';
//import 'package:flutter_state_management/feature/onboard/on_board_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginView(),
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey.shade300,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.light, elevation: 0),
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.indigo.shade500)),
    );
  }
}
