import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomerAddressLocation extends StatelessWidget {
  const CustomerAddressLocation({super.key, required this.lat, required this.lng});

  final num lat;
  final num lng;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(lat.toDouble(), lng.toDouble()),
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point:  LatLng(lat.toDouble(), lng.toDouble()),
                  builder: (ctx) => Container(
                    child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
