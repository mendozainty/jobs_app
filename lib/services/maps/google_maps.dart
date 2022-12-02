// google maps API Key AIzaSyDYrR-DUvT-DZ9qCl2DJ7UGGj-4ovl3-5Y
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jobs_app/constants/appBar_view.dart';

Future<List<Location>> getLatLong(String address) async {
  String localeIdentifier = 'pt_BR';
  final List<Location> location =
      await GeocodingPlatform.instance.locationFromAddress(
    address,
    localeIdentifier: localeIdentifier,
  );
  print(location);
  return location;
}

CameraPosition getMap(location) {
  final latLng = LatLng(location.Latitude, location.Longitude);
  late final CameraPosition cameraPosition =
      CameraPosition(target: latLng, zoom: 11.0, bearing: 0);
  return cameraPosition;
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('mapa'),
      /* body: GoogleMap(initialCameraPosition: ), */
    );
  }
}
