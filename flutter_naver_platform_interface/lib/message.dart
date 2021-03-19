import 'dart:core';

import 'naver_map_platform_interface.dart';

class TextureMessage {
  int? textureId;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    return pigeonMap;
  }

  static TextureMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return TextureMessage()..textureId = pigeonMap['textureId'] as int?;
  }
}

class CreateMessage extends TextureMessage {
  // late MapOption mapOption;
  late CameraPosition initialCameraPosition;

  @override
  Object encode() {
    return {'initialCameraPosition': initialCameraPosition.toMap()};
  }

  static CreateMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return CreateMessage()
      ..initialCameraPosition = CameraPosition.fromMap(
          pigeonMap['initialCameraPosition'] as Map<String, dynamic>)!
      ..textureId = pigeonMap['textureId'] as int?;
  }
}

class UpdatePolygon extends TextureMessage {
  Set<PolygonOverlay> previous = Set.identity();
  Set<PolygonOverlay> current = Set.identity();

  @override
  Object encode() {
    return {
      'previous': serializePolygonSet(previous),
      'current': serializePolygonSet(current)
    };
  }

  static UpdatePolygon decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return UpdatePolygon();
    // ..previous =
    //     keyByPolygonId(pigeonMap['previous']) as Set<PolygonOverlay>
    // ..textureId = pigeonMap['textureId'] as int?;
  }
}

Map<String, PolygonOverlay> keyByPolygonId(Iterable<PolygonOverlay> polygons) {
  if (polygons == null || polygons.isEmpty) return {};
  return Map<String, PolygonOverlay>.fromEntries(polygons.map(
      (e) => MapEntry<String, PolygonOverlay>(e.polygonOverlayId, e.clone())));
}

List<Map<String, dynamic>> serializePolygonSet(
    Iterable<PolygonOverlay> polygons) {
  return polygons.map<Map<String, dynamic>>((e) => e.toJson()).toList();
}
