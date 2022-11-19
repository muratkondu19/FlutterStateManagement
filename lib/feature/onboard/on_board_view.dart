import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../login/view/login_view.dart';
import '../product/model/state/project_context.dart';
import '../product/padding/page_padding.dart';
import '../product/padding/widget/on_board_card.dart';
import 'on_board_model.dart';
import 'tab_indicator.dart';

part './module/start_fab_button.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

//tabController için with SingleTickerProviderStateMixin eklendi.
class _OnBoardViewState extends State<OnBoardView> {
  final String _skipTitle = 'Skip';

  bool get _isLastPage => OnBoardModels.onBoardItems.length - 1 == _selectedIndex;
  bool get _isFirstPage => _selectedIndex == 0;
  int _selectedIndex = 0;

  // -----XX
  //Set state ile tüm widget ağacında bir hareketlenme olmaktadır,bu hareketlenmeden ötürü diğer widgetlarında  bundan etkilenebiliyor olması veya tetiklenmemsi olaiblir.
  //Bu sebeple state yönetim metotları projeye dahil edilir
  //Sadece değişmesi istenen, değişecek widget tetiklenir.
  //vanilla state has done
  ValueNotifier<bool> isBackEnable = ValueNotifier(false);
  // -----XX

  void _incrementSelectedPage([int? value]) {
    inspect(value);
    inspect(this); //tüm sayfayı logta görüntüleme
    setState(() {
      if (value != null) {
        _selectedIndex = value;
      } else {
        _selectedIndex++;
      }
    });
  }

  void _incrementAndChange([int? value]) {
    if (_isLastPage && value == null) {
      _changeBackEnable(true);
      return;
    }
    _changeBackEnable(false);
    _incrementSelectedPage(value);
  }

  void _changeBackEnable(bool value) {
    if (value == isBackEnable.value) {
      //aynı değer geliyor ise tetikleme yapma return et
      return;
    }
    isBackEnable.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
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
                //Start fab button'a sadece widgetı kullanan yer erişebilecek
                //sayfaya özel widgetı sadece sayfayı kullananlar görebilir
                _StartFabButton(
                  isLastPage: _isFirstPage,
                  onPressed: () {
                    _incrementAndChange();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
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

  AppBar _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(context.watch<ProductContext>().newUserName),
      //Status barın görünüm tipini belirler
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      //ValueListenableBuilder -> valueNotifier'i dinler.
      actions: [
        //isbackEnable tetiklendikçe ekranda çizimini yapar-
        ValueListenableBuilder<bool>(
            valueListenable: isBackEnable,
            builder: (BuildContext context, bool value, Widget? child) {
              return value
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        context.read<ProductContext>().changeName('murat');
                        //projedeki usercontext name olan tüm namelerin burada verilen değişken olması işlemi ->global provider kullanımı->proxyporvider
                        context.navigateToPage(const LoginView());
                      },
                      child: Text(_skipTitle));
            })
      ],
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
