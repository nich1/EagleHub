import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Map<String, dynamic>> data = [
  {
    'id': '1',
    'position': const LatLng(33.212082288367114, -97.15037357863325),
    'assetPath': 'images/Bruceteria.png',
    'title': 'Bruceteria',
  },
  {
    'id': '2',
    'position': const LatLng(33.202682616849565, -97.15860238464549),
    'assetPath': 'images/Bruceteria.png',
    'title': 'Champs',
  },
  {
    'id': '3',
    'position': const LatLng(33.20864098158666, -97.1467412364647),
    'assetPath': 'images/Bruceteria.png',
    'title': 'Eagle Landing',
  },
  {
    'id': '4',
    'position': const LatLng(33.21177987953803, -97.15555561979893),
    'assetPath': 'images/Bruceteria.png',
    'title': 'Kitchen West',
  },
  {
    'id': '5',
    'position': const LatLng(33.20807004346004, -97.15004990776785),
    'assetPath': 'images/Bruceteria.png',
    'title': 'Mean Greens Cafe',
  },
];

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Controller
  final Completer<GoogleMapController> _controller = Completer();

  final Map<String, Marker> _markers = {};

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
  final latlngForImages = [
    LatLng(33.212082288367114, -97.15037357863325),
    LatLng(33.202682616849565, -97.15860238464549),
    LatLng(33.20864098158666, -97.1467412364647),
    LatLng(33.21177987953803, -97.15555561979893),
    LatLng(33.20807004346004, -97.15004990776785),
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
    _generateMarkers();
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('i_theme/aubergine_theme.json')
        .then((value) {
      themeForMap = value;
    });
    packData();
  }

  @override
  Widget build(BuildContext context) {
    // Regular markers, Create markers before render map
    var markers = {
      Marker(
          markerId: const MarkerId('1'),
          position: const LatLng(33.212082288367114, -97.15037357863325),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure))
    };

    return Scaffold(
        body: SafeArea(
            child: GoogleMap(
      initialCameraPosition: _initialPosition,
      style: themeForMap,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _markers.values.toSet(),
    )));
  }

  final int imgSize = 100;

  _generateMarkers() async {
    for (int i = 0; i < data.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), data[i]['assetPath']);

      _markers[i.toString()] = Marker(
          markerId: MarkerId(i.toString()),
          position: data[i]['position'],
          icon: markerIcon,
          infoWindow: InfoWindow(title: data[i]['title']),
          onTap: () {
            print(
                'Test'); // Replace this with a link to respective menu when menus are complete
          });
      setState(() {});
    }
  }
}
