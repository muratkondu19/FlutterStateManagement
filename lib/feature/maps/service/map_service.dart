import 'package:vexana/vexana.dart';

import '../model/map_model.dart';

abstract class IMapService {
  final INetworkManager networkManager;
  IMapService(this.networkManager);
  Future<List<MapModel>> fetchMapItems();
}

class MapService extends IMapService {
  MapService(super.networkManager);

  @override
  Future<List<MapModel>> fetchMapItems() async {
    final response = await networkManager.send<MapModel, List<MapModel>>(_MapEndPoint.maps.withJson, parseModel: MapModel(), method: RequestType.GET);
    return response.data!;
  }
}

enum _MapEndPoint { maps }

extension _MapEndPointExtensions on _MapEndPoint {
  String get withJson => '$name.json';
}
