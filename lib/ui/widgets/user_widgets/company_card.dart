import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:test_eds_app/data/models/address_model.dart';
import 'package:test_eds_app/data/models/company_model.dart';
import 'package:latlong2/latlong.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({Key? key, required this.item, required this.address})
      : super(key: key);
  final Company item;
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                item.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.bs),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '"${item.catchPhrase}"',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        interactiveFlags: InteractiveFlag.none,
                        zoom: 1,
                        center: LatLng(
                          address.geo.lat,
                          address.geo.lng,
                        ),
                      ),
                      layers: [
                        TileLayerOptions(
                          opacity: 1,
                          tileProvider: NetworkTileProvider(),
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              point: LatLng(
                                address.geo.lat,
                                address.geo.lng,
                              ),
                              builder: (context) {
                                return const Icon(Icons.place);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    //Map triger on mouse wheel spining
                    Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(address.fullAddress),
              subtitle: Text(address.zipcode),
            ),
          ],
        ),
      ),
    );
  }
}
