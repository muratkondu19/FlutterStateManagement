import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_management/feature/onboard/tab_indicator.dart';
import 'package:flutter_state_management/feature/travel/view/travel_tab_view.dart';
import 'package:provider/provider.dart';

import 'feature/maps/view/map_select_view.dart';
import 'feature/onboard/on_board_view.dart';
import 'feature/product/model/state/project_context.dart';
import 'feature/product/model/state/user_context.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider(
        //   create: (context) => UserContext('a'),
        // ),
        ChangeNotifierProvider(create: (context) => ProductContext()),
        ProxyProvider<ProductContext, UserContext>(update: (context, productContext, userContext) {
          //UserContext var ise name update ediliyor, yok ise yeni name ile oluşturuluyor
          //Product context ile user context bağlanmış olmaktadır.
          return userContext != null ? userContext.copyWith(name: productContext.newUserName) : UserContext(productContext.newUserName);
        }),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: const TravelTabView(),
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey.shade300,
            tabBarTheme: TabBarTheme(
              labelColor: Colors.pink.shade700,
              unselectedLabelColor: Colors.pink.shade200,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.light, elevation: 0),
            floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.indigo.shade500)),
      ),
    );
  }
}
