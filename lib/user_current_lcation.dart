import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({Key key}) : super(key: key);

  @override
  _UserCurrentLocationState createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  Position _currentPosition;
  Widget _mapAreaWidget;

  @override
  void initState() {
    super.initState();
    _mapAreaWidget = _mapWhileLoading();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    try {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          _mapAreaWidget = _mapAfterLoading();
          debugPrint(_currentPosition.latitude.toString());
          debugPrint(_currentPosition.longitude.toString());
        });
      }).catchError((e) {
        debugPrint(e.toString());
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  _mapWhileLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Please wait. Your map is build for you.",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(height: 35.0, width: 35.0, child: CircularProgressIndicator()),
      ],
    );
  }

  _mapAfterLoading() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(7.8731, 80.7718),
        zoom: 8.5,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point:
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: _mapAreaWidget)));
  }
}
