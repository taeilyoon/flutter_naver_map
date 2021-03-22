part of flutter_naver_map;

class InfoWindow {
  LatLng position;
  String content;
  int? zIndex;
  int? maxWidth;
  Point? pixelOffset;
  Color? backGroundColor;
  Color? borderColor;
  double? borderWidth;
  bool? disableAutoPan;
  bool? disableAnchor;
  // bool anchorSkew;
  Size? anchorSize;
  String? anchorColor;

  InfoWindow(
      {required this.position,
      required this.content,
      this.zIndex = 1,
      this.anchorColor,
      this.anchorSize,
      this.backGroundColor,
      this.borderColor,
      this.borderWidth,
      this.disableAnchor,
      this.disableAutoPan,
      this.maxWidth,
      this.pixelOffset});
}
