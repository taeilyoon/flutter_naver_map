import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  NaverMapController controller;
  @override
  void initState() {
    super.initState();
  }

  List<LatLng> ls = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example yyapp'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addPath(PathOverlay(
              PathOverlayId("Asasd"),
              [
                LatLng(37.37544345085432, 127.11224555969238),
                LatLng(37.37230584065932, 127.10791110992432),
                LatLng(37.35975408751031, 127.10795402526855),
                LatLng(37.359924641705376, 127.11576461791992),
                LatLng(37.35931064479033, 127.12211608886719),
                LatLng(37.3604363039636, 127.12293148040771),
                LatLng(37.36354029942161, 127.12310314178465),
                LatLng(37.365213629488016, 127.12456226348876),
                LatLng(37.37524345085402, 127.11224555969238)
              ],
              color: Colors.black,
              width: 5));
        },
      ),
      body: NaverMap(
        controller: controller,
        initialCameraPosition:
            CameraPosition(target: LatLng(37.3674001, 127.1181196), zoom: 10),
        // onMapTap: (LatLng l) {
        //   print(l);
        // },
        onMapCreated: (c) {
          controller = c;
        },
        onMapTap: (lat) {
          this.controller.addMarker(Marker(
                  markerId: "${lat.latitude}",
                  position: lat,
                  eventsHandle: {
                    MapEventEnum.onRightClick: (_) {
                      print("aa");
                      ls.add(_);
                      this
                          .controller
                          .addPath(PathOverlay(PathOverlayId("text"), ls));
                      this.controller.removeMarker("${lat.latitude}");
                    }
                  }));
        },
        markers: [],
        pathOverlays: [
          PathOverlay(
              PathOverlayId("Asasd"),
              [
                LatLng(37.37544345085402, 127.11224555969238),
                LatLng(37.37230584065902, 127.10791110992432),
                LatLng(37.35975408751081, 127.10795402526855),
                LatLng(37.359924641705476, 127.11576461791992),
                LatLng(37.35931064479073, 127.12211608886719),
                LatLng(37.36043630196386, 127.12293148040771),
                LatLng(37.36354029942161, 127.12310314178465),
                LatLng(37.365211629488016, 127.12456226348876),
                LatLng(37.37544345085402, 127.11224555969238)
              ],
              color: Colors.black,
              width: 5)
        ],
      ),
    ));
  }
}
