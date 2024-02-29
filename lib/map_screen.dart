import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapsforge_flutter/core.dart';
import 'package:mapsforge_flutter/maps.dart';
import 'package:mapsforge_flutter/marker.dart';
import 'package:provider/provider.dart';

import 'map_data_provider.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.title});

  final String title;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  // Create the displayModel which defines and holds the view/display settings
  // like maximum zoomLevel.
  final displayModel = DisplayModel(deviceScaleFactor: 2);

  // Create the cache for assets
  final symbolCache = FileSymbolCache();

  // Bonus: A markerstore
  final MarkerDataStore markerDataStore = MarkerDataStore();

  // Future<MapModel> _createMapModel() async {
  //   // Load the mapfile which holds the openstreetmap® data. Use either MapFile.from() or load it into memory first (small files only) and use MapFile.using()
  //   ByteData content = await rootBundle.load('assets/vietnam.map');
  //   final mapFile =
  //   await MapFile.using(content.buffer.asUint8List(), null, null);
  //
  //   // Create the render theme which specifies how to render the informations
  //   // from the mapfile.
  //   final renderTheme = await RenderThemeBuilder.create(
  //     displayModel,
  //     'assets/render_themes/defaultrender.xml',
  //   );
  //   // Create the Renderer
  //   final jobRenderer =
  //   MapDataStoreRenderer(mapFile, renderTheme, symbolCache, true);
  //
  //   // Glue everything together into two models, the mapModel here and the viewModel below.
  //   MapModel mapModel = MapModel(
  //     displayModel: displayModel,
  //     renderer: jobRenderer,
  //   );
  //
  //   // Bonus: Add MarkerDataStore to hold added markers
  //   mapModel.markerDataStores.add(markerDataStore);
  //   return mapModel;
  // }

  Future<MapModel> _createMapModel() async {
    final mapData = Provider.of<MapDataProvider>(context).mapData!;
    final mapFile = await MapFile.using(mapData, null, null);

    // Create the render theme which specifies how to render the informations
    // from the mapfile.
    final renderTheme = await RenderThemeBuilder.create(
      displayModel,
      'assets/render_themes/defaultrender.xml',
    );
    // Create the Renderer
    final jobRenderer =
    MapDataStoreRenderer(mapFile, renderTheme, symbolCache, true);

    // Glue everything together into two models, the mapModel here and the viewModel below.
    final mapModel = MapModel(
      displayModel: displayModel,
      renderer: jobRenderer,
    );

    // Bonus: Add MarkerDataStore to hold added markers
    mapModel.markerDataStores.add(markerDataStore);
    return mapModel;
  }


  Future<ViewModel> _createViewModel() async {
    ViewModel viewModel = ViewModel(displayModel: displayModel);
    // set the initial position
    viewModel.setMapViewPosition(15.882388, 107.815054);
    // set the initial zoomlevel
    viewModel.setZoomLevel(6);
    // bonus feature: listen for long taps and add/remove a marker at the tap-positon
    viewModel.addOverlay(_MarkerOverlay(
      viewModel: viewModel,
      markerDataStore: markerDataStore,
      symbolCache: symbolCache,
      displayModel: displayModel,
    ));
    return viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('lib/image/logoseacom_resized.jpg')),
      body: MapviewWidget(
        displayModel: displayModel,
        createMapModel:_createMapModel,
        createViewModel: _createViewModel,
      ),
    );
  }
}

/// Bonus: An overlay is just a normal widget which will be drawn on top of the map. In this case we do not
/// draw anything but just receive long tap events and add/remove a marker to the datastore. Take note
/// that the marker needs to be initialized (async) and afterwards added to the datastore and the
/// setRepaint() method is called to inform the datastore about changes so that it gets repainted
class _MarkerOverlay extends StatefulWidget {
  final MarkerDataStore markerDataStore;

  final ViewModel viewModel;

  final SymbolCache symbolCache;

  final DisplayModel displayModel;

  const _MarkerOverlay({
    required this.viewModel,
    required this.markerDataStore,
    required this.symbolCache,
    required this.displayModel,
  });

  @override
  State<StatefulWidget> createState() {
    return _MarkerOverlayState();
  }
}

class _MarkerOverlayState extends State {
  @override
  _MarkerOverlay get widget => super.widget as _MarkerOverlay;

  PoiMarker? _marker;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TapEvent>(
        stream: widget.viewModel.observeLongTap,
        builder: (BuildContext context, AsyncSnapshot<TapEvent> snapshot) {
          if (snapshot.data == null) return const SizedBox();
          if (_marker != null) {
            widget.markerDataStore.removeMarker(_marker!);
          }

          _marker = PoiMarker(
            displayModel: widget.displayModel,
            src: 'assets/icons/marker.svg',
            height: 64,
            width: 48,
            latLong: snapshot.data!,
            position: Position.ABOVE,
          );

          _marker!.initResources(widget.symbolCache).then((value) {
            widget.markerDataStore.addMarker(_marker!);
            widget.markerDataStore.setRepaint();
          });

          return const SizedBox();
        });
  }
}
