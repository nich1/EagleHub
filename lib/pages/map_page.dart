import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Controller
  final Completer<GoogleMapController> _controller = Completer();

  // Start camera position
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(33.207722351604055, -97.15266474212606),
    zoom: 16,
  );

  // Dining Hall Images
  List<String> images = [
    'images/Bruceteria.png',
    'images/Champs.png',
    'images/EagleLanding.png',
    'images/KitchenWest.png',
    'images/MeanGreensCafe.png'
  ];

  // Dining Hall Coordinates
  final List<LatLng> latlngForImages = <LatLng>[
    const LatLng(33.212082288367114, -97.15037357863325),
    const LatLng(33.202682616849565, -97.15860238464549),
    const LatLng(33.20864098158666, -97.1467412364647),
    const LatLng(33.21177987953803, -97.15555561979893),
    const LatLng(33.20807004346004, -97.15004990776785),
  ];

  final List<Marker> myMarker = [];

  Future<Uint8List> getImagesFromMarkers(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  packData() async {
    for (int a = 0; a < images.length; a++) {
      final Uint8List iconMaker = await getImagesFromMarkers(images[a], 90);
      myMarker.add(Marker(
          markerId: MarkerId(a.toString()),
          position: latlngForImages[a],
          icon: BitmapDescriptor.fromBytes(iconMaker),
          infoWindow: InfoWindow(
            title: 'Title Marker: $a',
          )));
      setState(() {});
    }
  }

  String themeForMap = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('i_theme/dark_theme.json')
        .then((value) {
      themeForMap = value;
    });
    packData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GoogleMap(
                initialCameraPosition: _initialPosition,
                style: themeForMap,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                })));
  }
}
