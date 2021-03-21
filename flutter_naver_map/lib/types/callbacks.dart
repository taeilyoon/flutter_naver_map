part of flutter_naver_map;
// typedef void MapCreateCallback(NaverMapController controller);

typedef void CameraPositionCallback(CameraPosition position);

typedef void OnMarkerTab(Marker marker, Map<String, int> iconSize);

typedef void OnMapTap(LatLng latLng);

typedef void OnMapLongTap(LatLng latLng);

typedef void OnMapDoubleTap(LatLng latLng);

typedef void OnMapTwoFingerTap(LatLng latLng);

typedef void OnCameraChange(
    LatLng latLng, CameraChangeReason reason, bool isAnimated);

typedef void OnSymbolTap(LatLng position, String caption);
typedef void OnPathOverlayTab(PathOverlayId pathOverlayId);

enum MapEventEnum {
  // none,
  onTap,
  onRightClick,
  onMouseEnter,
  onMouseExit,
}

class MapEventModel {
  String id;
  MapEventEnum event = MapEventEnum.onTap;
  late Function func;
  MapEventModel({required this.id, required this.event, required this.func});
}
