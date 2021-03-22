import 'dart:html' as html;
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
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
    ..strokeWeight = 5
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
  js(web.NMap map) => webIcon != null
      ? web.Marker(this.toOptions..map = map)
      : web.Marker(this.toOptions..map = map);

  web.MarkerOptions get toOptions => web.MarkerOptions()
    ..position = this.position.js
    ..markerIcon = webIcon != null
        ? (web.MarkerIcon()
          ..content = this.webIcon?["content"]
          ..anchor = (this.webIcon?["anchor"] as Point).js)
        : null;
}

extension NaverMapPoint on Point {
  web.Point get js => web.Point(this.x, this.y);
}

extension WEbInfoWindow on InfoWindow {
  web.InfoWindow js(web.NMap map) =>
      web.InfoWindow(this.toOptions)..open(map, this.position.js);
  web.InfoWindowOptions get toOptions => web.InfoWindowOptions()
    ..anchorColor = this.anchorColor
    ..anchorSize = this.anchorSize?.js
    ..position = this.position.js
    ..backGroundColor = (this.backGroundColor ?? Colors.white).toHashString()
    ..borderColor = (this.borderColor ?? Colors.black).toHashString()
    ..maxWidth = this.maxWidth
    ..content = this.content;
}

extension WebSize on Size {
  get js => web.Size(this.width, this.height);
}

extension WebColorExtensions on Color {
  String toHashString() =>
      '#${this.red.toRadixString(16)}${this.green.toRadixString(16)}${this.blue.toRadixString(16)}';
}

extension WebEventEnum on MapEventEnum {
  String get js {
    switch (this) {
      case MapEventEnum.onClick:
        return "click";
        break;

      case MapEventEnum.onRightClick:
        return "rightclick";
        break;
      case MapEventEnum.onMouseOver:
        return "mouseover";
        break;
      case MapEventEnum.onMouseOut:
        return "mouseout";
        break;
      case MapEventEnum.onDoubleClick:
        return "dblclick";
        break;
      case MapEventEnum.onMouseMove:
        return "mousemove";

        break;
      case MapEventEnum.onDragStart:
        return "dragstart";

        break;
      case MapEventEnum.onDrag:
        return "drag";

        break;
      case MapEventEnum.onDragEnd:
        return "dragend";

        break;
      case MapEventEnum.onTouchStart:
        return "touchstart";

        break;
      case MapEventEnum.onTouchMove:
        return "touchmove";

        break;
      case MapEventEnum.onTouchEnd:
        return "touchend";
        break;
      case MapEventEnum.onPinchStart:
        return "pinchstart";
        break;
      case MapEventEnum.onPinch:
        return "pinch";
        break;
      case MapEventEnum.onPinchEnd:
        return "pinchend";
        break;
      case MapEventEnum.onTap:
        return "tap";
        break;
      case MapEventEnum.onLongTap:
        return "longtap";
        break;
      case MapEventEnum.onTwoFingerTap:
        return "twofingertap";
        break;
      case MapEventEnum.onDoubleTap:
        return "doubletap";
        break;
    }
  }
}
