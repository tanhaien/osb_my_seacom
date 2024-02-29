// map_data_provider.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MapDataProvider extends ChangeNotifier {
  Uint8List? _mapData;

  Uint8List? get mapData => _mapData;

  Future<void> loadMapData() async {

    final content = await rootBundle.load('assets/vietnam.map');
    _mapData = content.buffer.asUint8List();
    print('\n\n----------------------- offline map loaded -----------------------');
    notifyListeners(); // Notify listeners about data change
  }
}
