import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/feature/product/constant/image_enum.dart';
import 'package:flutter_state_management/feature/travel/model/travel_model.dart';

class TravelCubit extends Cubit<TravelStates> {
  TravelCubit() : super(TravelLoading());
  //cubit tarafında item tutmak istenirse
  List<TravelModel> allItems = [];

  Future<void> fetchItems() async {
    await Future.delayed(const Duration(seconds: 1));
    allItems = TravelModel.mockItmes;
    emit(TravelItemsLoaded(allItems)); //ekrana haber verme işlemi -> emit ->state gönderilir
  }

  void searchItems(String data) {
    final result = allItems.where((element) => element.title.contains(data)).toList();
    emit(TravelItemsLoaded(result));
  }

  void seeAllItems() {
    emit(TravelItemsSeeAll([ImageEnums.camp_alt.toPathFeed, ImageEnums.camp_alt2.toPathFeed]));
  }
}

abstract class TravelStates {}

class TravelLoading extends TravelStates {}

class TravelItemsLoaded extends TravelStates {
  final List<TravelModel> items;
  TravelItemsLoaded(this.items);
}

class TravelItemsSeeAll extends TravelStates {
  final List<String> images;
  TravelItemsSeeAll(this.images);
}
