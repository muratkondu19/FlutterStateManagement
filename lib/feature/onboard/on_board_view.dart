import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_management/feature/onboard/on_board_model.dart';
import 'package:flutter_state_management/feature/product/padding/page_padding.dart';
import 'package:flutter_state_management/feature/product/padding/widget/on_board_card.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

//tabController için with SingleTickerProviderStateMixin eklendi.
class _OnBoardViewState extends State<OnBoardView> with SingleTickerProviderStateMixin {
  final String _skipTitle = 'Skip';
  //late->bu değişken initState anında / ekran çizilmeye başlarken değerini alacak
  late final TabController _tabControoler;
  @override
  void initState() {
    super.initState();
    _tabControoler = TabController(length: OnBoardModels.onBoardItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //Status barın görünüm tipini belirler
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [TextButton(onPressed: () {}, child: Text(_skipTitle))],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chevron_left_outlined,
              color: Colors.grey,
            )),
      ),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            Expanded(child: _pageViewItem()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabPageSelector(
                  controller: _tabControoler,
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
    return FloatingActionButton(child: const Text('Next'), onPressed: () {});
  }

  PageView _pageViewItem() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return OnBoardCard(model: OnBoardModels.onBoardItems[index]);
      },
      itemCount: OnBoardModels.onBoardItems.length,
    );
  }
}
