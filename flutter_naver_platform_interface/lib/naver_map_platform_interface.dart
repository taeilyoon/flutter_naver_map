library flutter_naver_platform_interface;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_platform_interface/message.dart';
import 'dart:ui' as ui;
import 'method_channel_naver_map.dart';

part 'types/callbacks.dart';
part 'types/option.dart';

part 'types/camera.dart';

part 'types/circle_overlay.dart';

part 'types/location.dart';

part 'types/marker.dart';

part 'types/overlay_image.dart';

part 'types/path_overlay.dart';

part 'types/ui.dart';

part 'types/polygon_overlay.dart';

const String VIEW_TYPE = 'flutter_naver_map';

abstract class NaverMapPlatform {
  static NaverMapPlatform _instance = MethodChannelNaverMap();
  static NaverMapPlatform get instance => _instance;
  @visibleForTesting
  bool get isMock => false;

  static set instance(NaverMapPlatform instance) {
    if (!instance.isMock) {
      try {
        instance._verifyProvidesDefaultImplementations();
      } on NoSuchMethodError catch (_) {
        throw AssertionError(
            'Platform interfaces must not be implemented with `implements`');
      }
    }
    _instance = instance;
  }

  Future<int?> create(MapOption mapOption) async {
    throw UnimplementedError('create() has not been implemented.');
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Widget buildView(int textureId) {
    throw UnimplementedError('buildView() has not been implemented.');
  }

  void _verifyProvidesDefaultImplementations() {}

  Future updatePolygon(int id, List<PolygonOverlay> polys) async {
    throw UnimplementedError('updatePolygon() has not been implemented.');
  }

  Future updateMarker(int id, List<Marker> markers) async {
    throw UnimplementedError('updateMarker() has not been implemented.');
  }

  Future updateCircle(int id, List<CircleOverlay> a) async {}

  Future UpdatePolyline(int id, List<PathOverlay> a) async {}

  Future moveCamera(int id, CameraPosition cameraUpdate) async {}
  Future updateMap(int id, MapOption option) async {}
  Future updateEventHandler(int id, List<MapEventModel> events) async {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
