import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../product/init/network/network_product.dart';
import '../../product/utility/extension/map_model_marker.dart';
import '../service/map_service.dart';
import '../viewmodel/map_view_model.dart';

class MapSelectView extends StatefulWidget {
  const MapSelectView({Key? key}) : super(key: key);

  @override
  State<MapSelectView> createState() => _MapSelectViewState();
}

class _MapSelectViewState extends State<MapSelectView> {
  late final MapViewModel _mapViewModel;
  final double _cardSize = 200;
  GoogleMapController? _controller;
  //initstate bittikten sonra ilk tetiklenmektedir/ekran çizildikten sonra
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mapViewModel = MapViewModel(MapService(NetworkProduct.instance.networkManager));
    _mapViewModel.fetchAllMaps();
  }

  @override
  Widget build(BuildContext context) {
    //5 datanın ilki seçili olarak açılması talep ediliyor varsayılır ->modele firs latlng eklendi

    return Scaffold(
      // appBar: AppBar(elevation: kZero),
      body: Stack(children: [_googleMaps(), Positioned(height: _cardSize, right: 0, left: 0, bottom: kToolbarHeight, child: _pageViewAnimals())]),
    );
  }

  Widget _pageViewAnimals() {
    return Observer(builder: (_) {
      return PageView.builder(
          controller: PageController(viewportFraction: 0.8),
          itemCount: _mapViewModel.mapModelItems.length,
          onPageChanged: (value) {
            _mapViewModel.changeIndex(value);
            _controller?.animateCamera(CameraUpdate.newLatLng(_mapViewModel.mapModelItems[value].latLong));
          },
          itemBuilder: (context, index) {
            return Card(
              child: Image.network(_mapViewModel.mapModelItems[index].detail!.photoUrl ?? ''),
            );
          });
    });
  }

  Observer _googleMaps() {
    return Observer(builder: (_) {
      return _mapViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {
                _controller = controller;
              },
              markers: _mapViewModel.mapModelItems.toMarkers(_mapViewModel.selectedIndex),
              initialCameraPosition: CameraPosition(target: _mapViewModel.mapModelItems.first.latLong, zoom: 12));
    });
  }
}
