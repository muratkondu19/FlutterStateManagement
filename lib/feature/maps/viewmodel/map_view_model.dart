import 'package:mobx/mobx.dart';

import '../model/map_model.dart';
import '../service/map_service.dart';

part 'map_view_model.g.dart';

class MapViewModel = _MapViewModelBase with _$MapViewModel;

abstract class _MapViewModelBase with Store {
  final IMapService mapService;

  @observable
  List<MapModel> mapModelItems = [];

  @observable
  int selectedIndex = 0;

//değişkenin dinlenmesi ve değişmesi isteniyorsa observable kullanılır
  @observable
  bool isLoading = false;

  @action
  void _changeLoading() {
    isLoading = !isLoading;
  }

  _MapViewModelBase(this.mapService);
//ekrana haber verecek / reaksiyon verecek widgetlara action atanır.
  @action
  Future<void> fetchAllMaps() async {
    _changeLoading();
    final response = await mapService.fetchMapItems();
    _changeLoading();
    mapModelItems = response;
  }

  @action
  void changeIndex(int index) {
    selectedIndex = index;
  }
}
