import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter_naver_platform_interface/naver_map_platform_interface.dart';
import 'package:naver_map_js2dart/src/generated/naver_map_core.dart' as web;

extension convertMapOption on MapOption {
  get webMapOption =>
      web.MapOptions()..center = this.initialCameraPosition.target.js;
}

extension convertLatLng on LatLng {
  get js => web.LatLng(this.latitude, this.longitude);
  static fromJs(web.LatLng value) =>
      LatLng(value.lat().toDouble(), value.lng().toDouble());
}

extension convertPolygon on PolygonOverlay {
  web.Polygon js(web.NMap map) {
    print(this.outlineColor.toHashString());
    return web.Polygon(web.PolygonOptions()
      ..map = map
      ..paths = [
        web.LatLng(37.37544345085402, 127.11224555969238),
        web.LatLng(37.37230584065902, 127.10791110992432),
        web.LatLng(37.35975408751081, 127.10795402526855),
        web.LatLng(37.359924641705476, 127.11576461791992),
        web.LatLng(37.35931064479073, 127.12211608886719),
        web.LatLng(37.36043630196386, 127.12293148040771),
        web.LatLng(37.36354029942161, 127.12310314178465),
        web.LatLng(37.365211629488016, 127.12456226348876),
        web.LatLng(37.37544345085402, 127.11224555969238)
      ]
      ..fillColor = '#ff0000'
      ..fillOpacity = 0.3
      ..strokeColor = '#ff0000');
    // ..addListener(eventName, listener);
  }

  web.PolygonOptions get toOptions => web.PolygonOptions()
    ..paths = this.coordinates.map<web.LatLng>((e) => e.js).toList()
    ..strokeColor = this.outlineColor.toHashString()
    ..strokeWeight = this.outlineWidth
    ..strokeOpacity = this.outlineColor.alpha
    ..fillColor = this.color.toHashString();
}

extension convertMarker on Marker {
  js(web.NMap map) => web.Marker(web.MarkerOptions()
    ..map = map
    ..position = this.position.js);

  web.MarkerOptions get toOptions =>
      web.MarkerOptions()..position = this.position.js;
}

extension WebColorExtensions on Color {
  String toHashString() =>
      '#${this.red.toRadixString(16)}${this.green.toRadixString(16)}${this.blue.toRadixString(16)}';
}

extension WebEventEnum on MapEventEnum {
  String get js {
    switch (this) {
      case MapEventEnum.onTap:
        return "click";
        break;

      case MapEventEnum.onRightClick:
        return "rightclick";
        break;
    }
  }
}
