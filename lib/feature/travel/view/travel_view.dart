import 'package:flutter/material.dart';
import 'package:flutter_state_management/feature/product/padding/page_padding.dart';
import 'package:flutter_state_management/feature/travel/model/travel_model.dart';
import 'package:kartal/kartal.dart';

class TravelView extends StatefulWidget {
  TravelView({Key? key}) : super(key: key);

  @override
  State<TravelView> createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {
  final String heyJohnnWhereDoYouWantToGoToday = 'Hey John!\nWhere do you want to go today?';
  final String popularDestinationsDearYou = 'Popular destinations dear you';
  final String seeAll = 'See all';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heyJohnnWhereDoYouWantToGoToday,
              style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
            ),
            context.emptySizedHeightBoxLow,
            const TextField(
              decoration: InputDecoration(prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
            ),
            context.emptySizedHeightBoxLow,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  popularDestinationsDearYou,
                  style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(seeAll, style: context.textTheme.subtitle1?.copyWith(color: context.colorScheme.error))
              ],
            ),
            SizedBox(
              height: context.dynamicHeight(0.26),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    child: SizedBox(
                      width: context.dynamicWidth(0.38),
                      child: Image.asset(TravelModel.mockItmes[index].imagePath),
                    ),
                  );
                },
                itemCount: TravelModel.mockItmes.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
