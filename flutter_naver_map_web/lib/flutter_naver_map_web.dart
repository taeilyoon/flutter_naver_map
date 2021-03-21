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
    var poly = _naverMaps[id]?["polygons"] as List<PolygonOverlay>;
    var polyjs = (_naverMaps[id]?["polygonjs"] as Map<String, web.Polygon>);

    poly.forEach((element) {
      if (newPolygon.contains(element)) {
        //Modify
        var newElement = newPolygon.firstWhere((newElement) =>
            element.polygonOverlayId == newElement.polygonOverlayId);
        if (newElement != element) {
          polyjs[element.polygonOverlayId]?.setOptions(newElement.toOptions);

          polyjs[element.polygonOverlayId]?.clearListeners("click");
          polyjs[element.polygonOverlayId]?.clearListeners("rightClick");
          polyjs[element.polygonOverlayId]?.addListener("click",
              allowInterop(() {
            if (element.onTap != null) {
              element.onTap!(element.polygonOverlayId);
            }
          }));
          element.eventsHandle?.forEach((key, value) {
            polyjs[element.polygonOverlayId]?.addListener(key.js,
                allowInterop(() {
              value(element.polygonOverlayId);
            }));
          });
        }
      } else {
        polyjs[element.polygonOverlayId]?.setMap(null);
        poly.remove(element);
      }
    });

    newPolygon.where((element) => !poly.contains(element)).forEach((element) {
      poly.add(element);
      polyjs.putIfAbsent(element.polygonOverlayId, () => element.js(map));
      polyjs[element.polygonOverlayId]?.addListener("click", allowInterop(() {
        if (element.onTap != null) {
          element.onTap!(element.polygonOverlayId);
        }
      }));
      element.eventsHandle?.forEach((key, value) {
        var eventName = key.js;
        polyjs[element.polygonOverlayId]?.addListener(eventName,
            allowInterop(() {
          value(element.polygonOverlayId);
        }));
      });
    });
  }

  @override
  Future updateMarker(int id, List<Marker> newMarkers) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    var markers = _naverMaps[id]?["markers"] as List<Marker>;
    var markerjs = (_naverMaps[id]?["markerjs"] as Map<String, web.Marker>);
    markers.forEach((element) {
      if (newMarkers.contains(element)) {
        //Modify
        var newElement = newMarkers.firstWhere(
            (newElement) => element.markerId == newElement.markerId);
        if (newElement != element) {
          markerjs[element.markerId]?.setOptions(newElement.toOptions);
          markerjs[element.markerId]?.clearListeners("click");
          markerjs[element.markerId]?.addListener("click", allowInterop((e) {
            print(e);
          }));
          markerjs[element.markerId]?.clearListeners("click");
          markerjs[element.markerId]?.clearListeners("rightClick");
          markerjs[element.markerId]?.addListener("click", allowInterop(() {
            if (element.onMarkerTab != null) {
              element.onMarkerTab!(element, {});
            }
          }));
          element.eventsHandle?.forEach((key, value) {
            markerjs[element.markerId]?.addListener(key.js, allowInterop(() {
              value(element.markerId);
            }));
          });
        } else {
          //Remove
          markerjs[element.markerId]!.setMap(null);
          markers.remove(element);
        }
      }
    });
    newMarkers
        .where((element) => !markers.contains(element))
        .forEach((element) {
      markers.add(element);
      markerjs.putIfAbsent(element.markerId, () => element.js(map));
    });
  }

  @override
  Future updateEventHandler(int textureId, List<MapEventModel> events) async {
    web.NMap map = _naverMaps[textureId]!["map"].webMap;

    MapEventEnum.values.forEach((e) => map.clearListeners(e.js));
    var tap =
        events.where((element) => element.event == MapEventEnum.onTap).toList();
    map.addListener("click", allowInterop((jsLatLng) {
      print(tap.length);
    }));
    if (tap.isNotEmpty) {
      map.addListener("click", allowInterop((jsLatLng) {
        print(tap.length);
        LatLng latLng = LatLng(jsLatLng.coord.y, jsLatLng.coord.x);
        tap.forEach((element) {
          element.func(latLng);
        });
      }));
    }
    var rightClick =
        events.where((element) => element.event == MapEventEnum.onTap).toList();
    if (tap.isNotEmpty) {
      map.addListener(rightClick[0].event.js, allowInterop((jsLatLng) {
        LatLng latLng = LatLng(jsLatLng.coord.y, jsLatLng.coord.x);
        rightClick.forEach((element) {
          element.func(latLng);
        });
      }));
    }
  }

  Future UpdatePolyline(int id, List<PathOverlay> newPolyline) async {
    var map = (_naverMaps[id]?["map"] as _FlutterNaverMap).webMap;
    var polylines = _naverMaps[id]?["polylines"] as List<PathOverlay>;
    var polylinejs =
        (_naverMaps[id]?["polylinejs"] as Map<String, web.Polyline>);

    polylines.forEach((element) {
      if (newPolyline.contains(element)) {
        //Modify
        var newElement = newPolyline.firstWhere(
            (newElement) => element.pathOverlayId == newElement.pathOverlayId);
        if (newElement != element) {
          polylinejs[element.pathOverlayId]?.setOptions(newElement.toOptions);
          polylinejs[element.pathOverlayId]?.clearListeners("click");
          polylinejs[element.pathOverlayId]?.addListener("click",
              allowInterop((e) {
            print(e);
          }));
          polylinejs[element.pathOverlayId]?.clearListeners("click");
          polylinejs[element.pathOverlayId]?.clearListeners("rightClick");
          polylinejs[element.pathOverlayId]?.addListener("click",
              allowInterop(() {
            if (element.onPathOverlayTab != null) {
              element.onPathOverlayTab!(element.pathOverlayId);
            }
          }));
          element.eventsHandle?.forEach((key, value) {
            polylinejs[element.pathOverlayId]?.addListener(key.js,
                allowInterop(() {
              value(element.pathOverlayId);
            }));
          });
        } else {
          //Remove
          polylinejs[element.pathOverlayId]!.setMap(null);
          polylines.remove(element);
        }
      }
    });
    newPolyline
        .where((element) => !polylines.contains(element))
        .forEach((element) {
      polylines.add(element);
      polylinejs.putIfAbsent(
          element.pathOverlayId.value, () => element.js(map));
    });
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
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.border = 'none';
    webMap = web.NMap(mapDivElement, option.webMapOption);
    Future.delayed(Duration.zero, () {
      webMap.setSize(
          web.Size(mapDivElement.clientWidth, mapDivElement.clientHeight));
    });
    ui.platformViewRegistry.registerViewFactory('$elementName-$textureId',
        (int viewId) {
      return mapDivElement;
    });
  }

  void dispose() async {
    mapDivElement.remove();
  }
}
