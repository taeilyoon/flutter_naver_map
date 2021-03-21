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

extension convertPolyline on PathOverlay {
  web.Polyline js(web.NMap map) => web.Polyline(this.toOptions..map = map);

  web.PolylineOptions get toOptions => web.PolylineOptions()
    ..clickable = true
    ..path = this.coords.map<web.LatLng>((e) => e.js).toList()
    ..strokeColor = this.color.toHashString()
    ..strokeOpacity = this.color.alpha;
}

extension convertPolygon on PolygonOverlay {
  web.Polygon js(web.NMap map) {
    print(this.outlineColor.toHashString());
    return web.Polygon(this.toOptions..map = map);
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
      case MapEventEnum.onMouseEnter:
        return "mouseover";
        break;
      case MapEventEnum.onMouseExit:
        return "mouseout";
        break;
      case MapEventEnum.onMouseExit:
        return "mouseout";
        break;
    }
  }
}
