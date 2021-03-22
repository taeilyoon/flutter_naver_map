part of flutter_naver_map;

class MapOption {
  CameraPosition initialCameraPosition;
  bool scaleControl = true;
  bool logoControl = true;
  bool mapDataControl = true;
  bool mapTypeControl = false;
  bool zoomControl = false;

  MapOption({
    required this.initialCameraPosition,
  });
}
