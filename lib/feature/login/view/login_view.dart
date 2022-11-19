// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_state_management/feature/product/utility/input_decoration.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_state_management/feature/product/constant/image_enum.dart';

import '../../product/padding/page_padding.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  final String rememberMe = 'Remember me';
  final String login = 'Login';
  final String enterUsername = 'Enter Username';
  final String username = 'Username';
  final String login2 = 'Login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.2), width: context.dynamicWidth(0.3), child: ImageEnums.door.toImage),
            Text(
              login2,
              style: context.textTheme.headline4,
            ),
            TextField(decoration: ProjectInputs('$enterUsername', '$username')),
            ElevatedButton(onPressed: () {}, child: Center(child: Text(login))),
            CheckboxListTile(title: Text('$rememberMe'), value: true, onChanged: (value) {})
          ],
        ),
      ),
    );
  }
}
