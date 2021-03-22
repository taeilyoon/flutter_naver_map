// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_naver_platform_interface/naver_map_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:ui' as ui;
import 'package:naver_map_js2dart/src/generated/naver_map_core.dart' as web;
import 'typeconvert.dart';

var elementName = "naver_map";

class FlutterNaverMap extends NaverMapPlatform {
  static void registerWith(Registrar registrar) {
    NaverMapPlatform.instance = FlutterNaverMap();
  }

  Map<int, Map<String, dynamic>> _naverMaps = <int, Map<String, dynamic>>{};

  int _textureCounter = 1;
  @override
  Future<void> init() async {
    return _disposeAllMap();
  }

  @override
  Future<int> create(MapOption mapOption) async {
    final int textureId = _textureCounter;
    _textureCounter++;
    final map = _FlutterNaverMap(textureId: textureId, option: mapOption);
    map.initialize();
    _naverMaps.putIfAbsent(
        textureId,
        () => {
              "map": map,
              "markers": <Marker>[],
              "markerjs": <String, web.Marker>{},
              "polygons": <PolygonOverlay>[],
              "polygonjs": <String, web.Polygon>{},
              "polylines": <PathOverlay>[],
              "polylinejs": <String, web.Polyline>{},
              "circles": <CircleOverlay>[],
              "circlejs": <String, web.Circle>{},
              "window": null,
              "windowjs": null
            });
    // web.Polygon(web.PolygonOptions()
    //   ..map = map.webMap
    //   ..paths = [
    //     web.LatLng(37.37544345085402, 127.11224555969238),
    //     web.LatLng(37.37230584065902, 127.10791110992432),
    //     web.LatLng(37.35975408751081, 127.10795402526855),
    //     web.LatLng(37.359924641705476, 127.11576461791992),
    //     web.LatLng(37.35931064479073, 127.12211608886719),
    //     web.LatLng(37.36043630196386, 127.12293148040771),
    //     web.LatLng(37.36354029942161, 127.12310314178465),
    //     web.LatLng(37.365211629488016, 127.12456226348876),
    //     web.LatLng(37.37544345085402, 127.11224555969238)
    //   ]
    //   ..fillColor = '#ff0000'
    //   ..fillOpacity = 0.3
    //   ..strokeColor = '#ff0000');
    return textureId;
  }

  @override
  Widget buildView(int textureId) {
    return HtmlElementView(viewType: '$elementName-$textureId');
  }

  void _disposeAllMap() {
    _naverMaps.values.forEach((videoPlayer) => videoPlayer["map"]?.dispose());
    _naverMaps.clear();
  }

  @override
  Future<void> dispose(int textureId) async {
    _naverMaps[textureId]?["map"].dispose();
    _naverMaps.remove(textureId);
    return null;
  }

  @override
  Future updatePolygon(int id, List<PolygonOverlay> newPolygon) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    var poligons = _naverMaps[id]?["polygons"] as List<PolygonOverlay>;
    var polyjs = (_naverMaps[id]?["polygonjs"] as Map<String, web.Polygon>);
    var newOne = newPolygon.toSet().difference(poligons.toSet());
    var modiOne = newPolygon.toSet().intersection(poligons.toSet());
    var deleteOne = polyjs.keys
        .toSet()
        .difference(newOne.map((e) => e.polygonOverlayId).toSet());

    newOne.forEach((element) {
      web.Polygon _ = element.js(map);
      polyjs[element.polygonOverlayId] = _;
      MapEventEnum.values.forEach((en) {
        _.addListener(en.js, allowInterop((_) {
          (element.eventsHandle![en] ??
              (_) {
                print(_);
              })(element.polygonOverlayId);
        }));
      });
    });
    modiOne.forEach((element) {
      polyjs[element.polygonOverlayId]?.setOptions(element.toOptions);
      MapEventEnum.values.forEach((en) {
        polyjs[element.polygonOverlayId]?.clearListeners(en.js);
      });
      MapEventEnum.values.forEach((en) {
        polyjs[element.polygonOverlayId]?.addListener(en.js, allowInterop((_) {
          (element.eventsHandle![en] ?? () {})();
        }));
      });
    });
    deleteOne.forEach((element) {
      // print(markerjs[element.markerId]);
      polyjs[element]?.setMap(null);
      polyjs.remove(element);
      poligons.removeWhere((e) => e.polygonOverlayId == element);
      print(poligons);
      print(polyjs);
    });

    poligons = newPolygon;
  }

  @override
  Future updateMarker(int id, List<Marker> newMarkers) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    var markers = _naverMaps[id]?["markers"] as List<Marker>;
    var markerjs = (_naverMaps[id]?["markerjs"] as Map<String, web.Marker>);

    var newOne = newMarkers.toSet().difference(markers.toSet());
    var modiOne = newMarkers.toSet().intersection(markers.toSet());
    var deleteOne =
        markerjs.keys.toSet().difference(newOne.map((e) => e.markerId).toSet());
    newOne.forEach((element) {
      web.Marker _ = element.js(map);
      markerjs[element.markerId] = _;
      MapEventEnum.values.forEach((en) {
        _.addListener(en.js, allowInterop((_) {
          (element.eventsHandle![en] ??
              (_) {
                print(_);
              })(element.markerId);
        }));
      });
    });
    modiOne.forEach((element) {
      markerjs[element.markerId]?.setOptions(element.toOptions);
      MapEventEnum.values.forEach((en) {
        markerjs[element.markerId]?.clearListeners(en.js);
      });
      MapEventEnum.values.forEach((en) {
        markerjs[element.markerId]?.addListener(en.js, allowInterop((_) {
          (element.eventsHandle![en] ?? () {})();
        }));
      });
    });
    deleteOne.forEach((element) {
      // print(markerjs[element.markerId]);
      markerjs[element]?.setMap(null);
      markerjs.remove(element);
      markers.removeWhere((e) => e.markerId == element);
      print(markers);
      print(markerjs);
    });

    markers = newMarkers;
  }

  @override
  Future updateEventHandler(int textureId, List<MapEventModel> events) async {
    web.NMap map = _naverMaps[textureId]!["map"].webMap;

    MapEventEnum.values.forEach((e) => map.clearListeners(e.js));

    var tap = events
        .where((element) => element.event == MapEventEnum.onClick)
        .toList();
    if (tap.isNotEmpty) {
      map.addListener("click", allowInterop((jsLatLng) {
        LatLng latLng = LatLng(jsLatLng.coord.y, jsLatLng.coord.x);
        tap.forEach((element) {
          element.func(latLng);
        });
      }));
    }
    // var rightClick = events
    //     .where((element) => element.event == MapEventEnum.onRightClick)
    //     .toList();
    // if (tap.isNotEmpty) {
    //   map.addListener(rightClick[0].event.js, allowInterop((jsLatLng) {
    //     LatLng latLng = LatLng(jsLatLng.coord.y, jsLatLng.coord.x);
    //     rightClick.forEach((element) {
    //       element.func(latLng);
    //     });
    //   }));
    // }
  }

  @override
  Future UpdatePolyline(int id, List<PathOverlay> newPolyline) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    var markers = _naverMaps[id]?["polylines"] as List<PathOverlay>;
    var markerjs = (_naverMaps[id]?["polylinejs"] as Map<String, web.Polyline>);

    var newOne = newPolyline.toSet().difference(markers.toSet());
    var modiOne = newPolyline.toSet().intersection(markers.toSet());
    var deleteOne = markerjs.keys
        .toSet()
        .difference(newOne.map((e) => e.pathOverlayId.value).toSet());
    newOne.forEach((element) {
      web.Polyline _ = element.js(map);
      markerjs[element.pathOverlayId.value] = _;
      MapEventEnum.values.forEach((en) {
        _.addListener(en.js, allowInterop((_) {
          (element.eventsHandle![en] ??
              (_) {
                print(_);
              })(element.pathOverlayId.value);
        }));
      });
    });
    modiOne.forEach((element) {
      markerjs[element.pathOverlayId.value]?.setOptions(element.toOptions);
      MapEventEnum.values.forEach((en) {
        markerjs[element.pathOverlayId.value]?.clearListeners(en.js);
      });
      MapEventEnum.values.forEach((en) {
        markerjs[element.pathOverlayId.value]?.addListener(en.js,
            allowInterop((_) {
          (element.eventsHandle![en] ?? (_) {})(element.pathOverlayId.value);
        }));
      });
    });
    deleteOne.forEach((element) {
      // print(markerjs[element.markerId]);
      markerjs[element]?.setMap(null);
      markerjs.remove(element);
      markers.removeWhere((e) => e.pathOverlayId.value == element);
      print(markers);
      print(markerjs);
    });

    markers = newPolyline;
  }

  @override
  Future updateCircle(int id, List<CircleOverlay> a) async {}
  @override
  Future moveCamera(int id, CameraPosition cameraPosition) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    map.setCenter(cameraPosition.target.js);
    map.setZoom(cameraPosition.zoom, true);
  }

  @override
  Future updateMap(int id, MapOption option) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    map.setOptions(option.webMapOption, 0);
  }

  @override
  Future showWindow(
    int id,
    InfoWindow window,
    String markerId,
  ) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    _naverMaps[id]?["window"] = window;
    print(_naverMaps[id]?["window"]);
    var info = _naverMaps[id]?["window"] as InfoWindow;
    var infojs = _naverMaps[id]?["windowjs"] as web.InfoWindow?;
    var markerjs = _naverMaps[id]?["markerjs"] as Map<String, web.Marker>;
    infojs?.close();
    var a = info.js(map);
    print(a);
    _naverMaps[id]?["windowjs"] = a;

    Future.delayed(Duration(seconds: 1), () {
      _naverMaps[id]?["windowjs"].open(map, markerjs[markerId]);
    });
  }

  void hideWindow(int id) {
    var info = _naverMaps[id]?["window"] as InfoWindow?;
    var infojs = _naverMaps[id]?["windowjs"] as web.InfoWindow?;
    infojs?.close();
    _naverMaps[id]?["window"] = null;
    _naverMaps[id]?["windowjs"] = null;
  }
}

class _FlutterNaverMap {
  MapOption option;

  _FlutterNaverMap({required this.textureId, required this.option});

  final int textureId;
  late HtmlElement mapDivElement;
  bool isInitialized = false;
  bool isBuffering = false;
  late web.NMap webMap;

  void initialize() {
    mapDivElement = DivElement()
      ..id = '$elementName-$textureId'
      ..style.border = 'none';
    webMap = web.NMap(mapDivElement, option.webMapOption);

    ui.platformViewRegistry.registerViewFactory('$elementName-$textureId',
        (int viewId) {
      Future.delayed(Duration(milliseconds: 100), () {
        webMap.setSize(
            web.Size(mapDivElement.clientWidth, mapDivElement.clientHeight));
      });
      return mapDivElement;
    });
  }

  void dispose() async {
    mapDivElement.remove();
  }
}
