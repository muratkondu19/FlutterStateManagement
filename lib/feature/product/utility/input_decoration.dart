import 'package:flutter/material.dart';

class ProjectInputs extends InputDecoration {
  const ProjectInputs(String title, String hint)
      : super(border: const OutlineInputBorder(), labelText: title, hintText: hint, focusColor: Colors.blue, iconColor: Colors.blueGrey);
}
