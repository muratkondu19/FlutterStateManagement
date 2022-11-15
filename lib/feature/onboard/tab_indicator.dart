import 'package:flutter/material.dart';

import 'on_board_model.dart';

class TabIndicator extends StatefulWidget {
  const TabIndicator({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;
  @override
  State<TabIndicator> createState() => _TabIndicatorState();
}

class _TabIndicatorState extends State<TabIndicator> with SingleTickerProviderStateMixin {
  //late->bu değişken initState anında / ekran çizilmeye başlarken değerini alacak
  late final TabController _tabControoler;

  //üst bir widget ile alt bir widget değiştirilmek isteniyorsa -> selectedindex değeri için
  @override
  void didUpdateWidget(covariant TabIndicator oldWidget) {
    //bir önceki widgeti verir, widget vurada yakalanabilmekte
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabControoler.animateTo(widget.selectedIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabControoler = TabController(length: OnBoardModels.onBoardItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabPageSelector(
      controller: _tabControoler,
    );
  }
}
