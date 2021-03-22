import 'dart:math';

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
  var map = [
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
    [
      LatLng(37.375345085402, 127.11224555969238),
      LatLng(37.36230584065902, 127.10791110992432),
      LatLng(37.35975408751081, 127.10795402526855),
      LatLng(37.329924641705476, 127.11576461791992),
      LatLng(37.356931064479073, 127.12211608886719),
      LatLng(37.313043630196386, 127.12293148040771),
      LatLng(37.26354029942161, 127.12310314178465),
      LatLng(37.165211629488016, 127.12456226348876),
      LatLng(37.23544345085402, 127.13224555969238)
    ],
    [
      LatLng(37.37544345085402, 127.15224555969238),
      LatLng(37.37230584065902, 127.13791110992432),
      LatLng(37.35975408751081, 127.13795402526855),
      LatLng(37.359924641705476, 127.12576461791992),
      LatLng(37.35931064479073, 127.12611608886719),
      LatLng(37.36043630196386, 127.12293548040771),
      LatLng(37.36354029942161, 127.12310414178465),
      LatLng(37.365211629488016, 127.12457226348876),
      LatLng(37.37544345085402, 127.11224757969238)
    ],
    [
      LatLng(37.37544345085402, 127.11234555969238),
      LatLng(37.37230584065902, 127.11791110992432),
      LatLng(37.35975408751081, 127.11795402526855),
      LatLng(37.359924641705476, 127.41576461791992),
      LatLng(37.35931064479073, 127.12211608886719),
      LatLng(37.36043630196386, 127.15293148040771),
      LatLng(37.36354229942161, 127.16310314178465),
      LatLng(37.365211629488016, 127.12456826348876),
      LatLng(37.37544345085402, 127.18224555969238)
    ],
    [
      LatLng(37.37544345085406, 127.11234655969238),
      LatLng(37.37230584065902, 127.11791210992432),
      LatLng(37.35975408751081, 127.11795402526855),
      LatLng(37.35992464170536, 127.41576461791992),
      LatLng(37.35931064479273, 127.12211607086719),
      LatLng(37.36043630196786, 127.15293148040771),
      LatLng(37.36354229942461, 127.16310314178465),
      LatLng(37.365211629833016, 127.12456826348876),
      LatLng(37.37544349085402, 127.18224553069238)
    ],
  ];

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example yyapp'),
      ),
      drawer: ListView(
        addAutomaticKeepAlives: true,
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var contentString = [
          //   '<div class="iw_inner">',
          //   '   <h3>서울특별시청</h3>',
          //   '   <p>서울특별시 중구 태평로1가 31 | 서울특별시 중구 세종대로 110 서울특별시청<br>',
          //   '       <img src="./img/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" /><br>',
          //   '       02-120 | 공공,사회기관 > 특별,광역시청<br>',
          //   '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
          //   '   </p>',
          //   '</div>'
          // ].join('');

          // controller.showInfoWindow(
          //     InfoWindow(
          //         position: LatLng(37.3674001, 127.1181196),
          //         content: contentString),
          //     "info");

          controller.updatePolygon([
            PolygonOverlay("polygonOverlayId", [
              LatLng(37.37544345085402, 127.11224555969238),
              LatLng(37.37230584065902, 127.10791110992432),
              LatLng(37.35975408751081, 127.10795402526855),
              LatLng(37.359924641705476, 127.11576461791992),
              LatLng(37.35931064479073, 127.12211608886719),
              LatLng(37.36043630196386, 127.12293148040771),
              LatLng(37.36354029942161, 127.12310314178465),
              LatLng(37.365211629488016, 127.12456226348876),
              LatLng(37.37544345085402, 127.11224555969238)
            ], onTap: (_) {
              print(_);
            }, globalZIndex: 100)
              ..eventsHandle = {
                MapEventEnum.onMouseOver: (_) {
                  controller.showInfoWindow(
                      InfoWindow(
                          position: LatLng(37.3674001, 127.1181196),
                          content: "hello"),
                      "info");
                },
                MapEventEnum.onMouseOut: (_) {
                  controller.hideInfoWindow();
                }
              }
          ]);
        },
      ),
      body: NaverMap(
        controller: controller,
        initialCameraPosition:
            CameraPosition(target: LatLng(37.3674001, 127.1181196), zoom: 10),
        onMapCreated: (c) {
          controller = c;
        },
        // onMapTap: (lat) {
        //   this.controller.addMarker(Marker(
        //           markerId: "${lat.latitude}",
        //           position: lat,
        //           eventsHandle: {
        //             MapEventEnum.onRightClick: (_) {
        //               this.controller.removeMarker("${lat.latitude}");
        //               this.ls.remove(lat);
        //               if (ls.length > 1) {
        //                 this.controller.updatePath(
        //                     [PathOverlay(PathOverlayId("test"), ls)]);
        //               }
        //             }
        //           }));
        //   this.ls.add(lat);
        //   if (ls.length > 1) {
        //     this
        //         .controller
        //         .updatePath([PathOverlay(PathOverlayId("test"), ls)]);
        //   }
        // },
        // markers: [
        //   Marker(
        //       markerId: "info",
        //       position: LatLng(37.3674001, 127.1181196),
        //       zIndex: 10,
        //       eventsHandle: {
        //         MapEventEnum.onMouseOver: (_) {
        //           controller.showInfoWindow(
        //               InfoWindow(
        //                   position: LatLng(37.3674001, 127.1181196),
        //                   content: "hello"),
        //               "info");
        //         },
        //         MapEventEnum.onMouseOut: (_) {
        //           controller.hideInfoWindow();
        //         }
        //       },
        //       webIcon: {
        //         "content":
        //             '<div style="display:inline-block;padding:5px;text-align:center;background-color:#fff;border:1px solid #000;"><span>' +
        //                 "${i}" +
        //                 '</span></div>',
        //         "anchor": new Point(5, 5),
        //         "css": {
        //           'font-size': '14px',
        //           'font-weight': 'bold',
        //           'color': '#f00'
        //         }
        //       })
        // ],
        // pathOverlays: [
        //   PathOverlay(
        //       PathOverlayId("Asasd"),
        //       [
        //         LatLng(37.37544345085402, 127.11224555969238),
        //         LatLng(37.37230584065902, 127.10791110992432),
        //         LatLng(37.35975408751081, 127.10795402526855),
        //         LatLng(37.359924641705476, 127.11576461791992),
        //         LatLng(37.35931064479073, 127.12211608886719),
        //         LatLng(37.36043630196386, 127.12293148040771),
        //         LatLng(37.36354029942161, 127.12310314178465),
        //         LatLng(37.365211629488016, 127.12456226348876),
        //         LatLng(37.37544345085402, 127.11224555969238)
        //       ],
        //       color: Colors.black,
        //       outlineWidth: 20,
        //       width: 5)
        //     ..eventsHandle = {
        //       MapEventEnum.onMouseOver: (_) {
        //         controller.showInfoWindow(
        //             InfoWindow(
        //                 position: LatLng(37.3674001, 127.1181196),
        //                 content: "hello"),
        //             "info");
        //       },
        //       MapEventEnum.onMouseOut: (_) {
        //         controller.hideInfoWindow();
        //       }
        //     }
        // ],
      ),
    ));
  }
}
