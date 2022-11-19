import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/feature/product/padding/page_padding.dart';
import 'package:flutter_state_management/feature/travel/cubit/travel_cubit.dart';
import 'package:flutter_state_management/feature/travel/model/travel_model.dart';
import 'package:kartal/kartal.dart';

class TravelView extends StatefulWidget {
  const TravelView({Key? key}) : super(key: key);

  @override
  State<TravelView> createState() => _TravelViewState();
}

// cubit/bloc projesinde proje başlar başlamaz bir datayı isteği nasıl çağırıp başlatabiliriz ->..fetchItems(),

class _TravelViewState extends State<TravelView> {
  final String heyJohnnWhereDoYouWantToGoToday = 'Hey John!\nWhere do you want to go today?';
  final String popularDestinationsDearYou = 'Popular destinations dear you';
  final String seeAll = 'See all';
  @override
  Widget build(BuildContext context) {
    //bu sayfaya obje gelicek ve bunlar takip edilecek ->BlocProvider
    return BlocProvider<TravelCubit>(
      create: (context) => TravelCubit()..fetchItems(),
      //sayfadaki değişiklikleri yaklama ve dinleme->BlocConsumer
      //TravelCubit->dinlenecek TravelStates->yollanacak
      child: BlocConsumer<TravelCubit, TravelStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                  TextField(
                    onChanged: (value) {
                      context.read<TravelCubit>().searchItems(value);
                    },
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
                  ),
                  context.emptySizedHeightBoxLow,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        popularDestinationsDearYou,
                        style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            context.read<TravelCubit>().seeAllItems();
                          },
                          child: Text(seeAll, style: context.textTheme.subtitle1?.copyWith(color: context.colorScheme.error)))
                    ],
                  ),
                  SizedBox(height: context.dynamicHeight(0.26), child: _itemsCastle(state, context)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state is TravelItemsSeeAll ? state.images.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final image = (state as TravelItemsSeeAll).images[index];
                        return Image.asset(image);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _itemsCastle(TravelStates state, BuildContext context) {
    //BlocSelector ile sayfadaki stateler dinlenebilir.
    return BlocSelector<TravelCubit, TravelStates, List<TravelModel>>(selector: (state) {
      return state is TravelItemsLoaded ? state.items : context.read<TravelCubit>().allItems;
    }, builder: (context, state) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Card(
              child: SizedBox(
                width: context.dynamicWidth(0.38),
                child: Image.asset(TravelModel.mockItmes[index].imagePath),
              ),
            );
          },
          itemCount: state.length);
    });
  }
}
