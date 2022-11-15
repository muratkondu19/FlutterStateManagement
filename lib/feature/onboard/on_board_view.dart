import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_management/feature/onboard/on_board_model.dart';
import 'package:flutter_state_management/feature/onboard/tab_indicator.dart';
import 'package:flutter_state_management/feature/product/padding/page_padding.dart';
import 'package:flutter_state_management/feature/product/padding/widget/on_board_card.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

//tabController için with SingleTickerProviderStateMixin eklendi.
class _OnBoardViewState extends State<OnBoardView> {
  final String _skipTitle = 'Skip';
  final String _start = 'Start';
  final String _next = 'Next';
  bool get _isLastPage => OnBoardModels.onBoardItems.length - 1 == _selectedIndex;
  bool get _isFirstPage => _selectedIndex == 0;
  int _selectedIndex = 0;

  void _incrementSelectedPage([int? value]) {
    inspect(value);
    inspect(this); //tüm sayfayı logta görüntüleme
    _selectedIndex = value ?? _selectedIndex++;
    setState(() {
      value ?? _selectedIndex++;
    });
  }

  void _incrementAndChange([int? value]) {
    if (_isLastPage && value == null) {
      return;
    }
    _incrementSelectedPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            Expanded(child: _pageViewItem()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabIndicator(
                  selectedIndex: _selectedIndex,
                ),
                _nextButton()
              ],
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton _nextButton() {
    return FloatingActionButton(
        child: Text(_isLastPage ? _start : _next),
        onPressed: () {
          _incrementAndChange();
        });
  }

  PageView _pageViewItem() {
    return PageView.builder(
      onPageChanged: (value) {
        _incrementAndChange(value);
      },
      itemBuilder: (context, index) {
        return OnBoardCard(model: OnBoardModels.onBoardItems[index]);
      },
      itemCount: OnBoardModels.onBoardItems.length,
    );
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      //Status barın görünüm tipini belirler
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [TextButton(onPressed: () {}, child: Text(_skipTitle))],
      leading: _isFirstPage
          ? null
          : IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chevron_left_outlined,
                color: Colors.grey,
              )),
    );
  }
}
