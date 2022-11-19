import 'package:flutter/material.dart';
import 'package:flutter_state_management/feature/travel/view/travel_view.dart';

enum TravelPages { home, bookmark, notification, profile }

class TravelTabView extends StatelessWidget {
  const TravelTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TravelPages.values.length,
      child: Scaffold(
          bottomNavigationBar: const BottomAppBar(
              child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.book),
              ),
              Tab(
                icon: Icon(Icons.notification_add),
              ),
              Tab(
                icon: Icon(Icons.people),
              )
            ],
          )),
          body: DefaultTabController(
            length: TravelPages.values.length,
            child: TabBarView(children: [TravelView(), const SizedBox(), const SizedBox(), const SizedBox()]),
          )),
    );
  }
}
