library flutter_naver_map;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter_naver_platform_interface/naver_map_platform_interface.dart';
part 'types/callbacks.dart';
part 'types/option.dart';
part 'types/camera.dart';
part 'types/circle_overlay.dart';
part 'types/location.dart';
part 'types/marker.dart';
part 'types/overlay_image.dart';
part 'types/path_overlay.dart';
part 'types/polygon_overlay.dart';

final NaverMapPlatform _videoPlayerPlatform = NaverMapPlatform.instance
  // This will clear all open videos on the platform when a full restart is
  // performed.
  ..init();

class NaverMap extends StatefulWidget {
  const NaverMap({
    Key? key,
    required this.controller,
    required this.onMapCreated,
    this.onMapTap,
    this.onMapRightClick,
    this.onMapLongTap,
    this.onMapDoubleTap,
    this.onMapTwoFingerTap,
    this.onSymbolTap,
    this.onCameraChange,
    this.onCameraIdle,
    this.pathOverlays,
    required this.initialCameraPosition,
    // this.mapType = MapType.Basic,
    this.liteModeEnable = false,
    this.nightModeEnable = false,
    this.indoorEnable = false,
    // this.activeLayers = const [MapLayer.LAYER_GROUP_BUILDING],
    this.buildingHeight = 1.0,
    this.symbolScale = 1.0,
    this.symbolPerspectiveRatio = 1.0,
    this.rotationGestureEnable = true,
    this.scrollGestureEnable = true,
    this.tiltGestureEnable = true,
    this.zoomGestureEnable = true,
    this.locationButtonEnable = false,
    this.initLocationTrackingMode = LocationTrackingMode.NoFollow,
    this.markers = const [],
    this.circles = const [],
    this.polygons = const [],
  }) : super(key: key);

  /// 지도가 완전히 만들어진 후에 컨트롤러를 파라미터로 가지는 콜백.
  /// 해당 콜백이 호출되기 전에는 지도가 만들어지는 중이다.
  final Function(NaverMapController controller) onMapCreated;

  final NaverMapController controller;

  /// 지도를 탭했을때 호출되는 콜백함수.
  ///
  ///
  /// 사용자가 선택한 지점의 [LatLng]을 파라미터로 가진다.
  final OnMapTap? onMapTap;
  final OnMapTap? onMapRightClick;

  /// ### 지도를 롱 탭했을때 호출되는 콜백함수. (Android only)
  ///
  /// 사용자가 선택한 지점의 [LatLng]을 파라미터로 가진다.
  final OnMapLongTap? onMapLongTap;

  /// 카메라가 움직일때 호출되는 콜백
  final OnCameraChange? onCameraChange;

  /// 카메라의 움직임이 완료되었을때 호출되는 콜백
  final Function? onCameraIdle;

  /// 카메라의 최초 포지션.
  /// </br>
  /// <p>initial tracking mode 가 [LocationTrackingMode.None]이거나 [LocationTrackingMode.NoFollow]인 경우에만 반영된디.</p>
  final CameraPosition initialCameraPosition;

  /// 지도 타입 설정.
  // final MapType mapType;

  /// 이 속성을 사용하면 라이트 모드를 활성화할 수 있습니다.
  /// 기본값은 false입니다.
  /// 라이트 모드가 활성화되면 지도의 로딩이 빨라지고 메모리 소모가 줄어듭니다.
  /// 그러나 다음과 같은 제약이 생깁니다.
  ///
  /// - 지도의 전반적인 화질이 하락합니다.
  /// - Navi 지도 유형을 사용할 수 없습니다.
  /// - 레이어 그룹을 활성화할 수 없습니다.
  /// - 실내지도, 야간 모드를 사용할 수 없습니다.
  /// - 디스플레이 옵션을 변경할 수 없습니다.
  /// - 카메라가 회전하거나 기울어지면 지도 심벌도 함께 회전하거나 기울어집니다.
  /// - 줌 레벨이 커지거나 작아지면 지도 심벌도 일정 정도 함께 커지거나 작아집니다.
  /// - 지도 심벌의 클릭 이벤트를 처리할 수 없습니다.
  /// - 마커와 지도 심벌 간 겹침을 처리할 수 없습니다.
  final bool liteModeEnable;

  /// 속성을 사용하면 야간 모드를 활성화할 수 있습니다. 야간 모드가 활성화되면 지도의
  /// 전반적인 스타일이 어두운 톤으로 변경됩니다. 단, 지도 유형이 야간 모드를 지원하지
  /// 않을 경우 야간 모드를 활성화하더라도 아무런 변화가 일어나지 않습니다.
  /// Navi 지도 유형만이 야간 모드를 지원합니다.
  /// 기본값은 fasle 입니다.
  final bool nightModeEnable;

  /// 해당 속성을 사용하면 실내지도를 활성화할 수 있습니다.
  /// 기본값은 false 입니다.
  /// 실내지도가 활성화되면 줌 레벨이 일정 수준 이상이고 실내지도가 있는 영역에 지도의
  /// 중심이 위치할 경우 자동으로 해당 영역에 대한 실내지도가 나타납니다.
  /// 단, 지도 유형이 실내지도를 지원하지 않으면 실내지도를 활성화하더라도 아무런 변화가
  /// 일어나지 않습니다. Basic, Terrain 지도 유형만이 실내지도를 지원합니다.
  final bool indoorEnable;

  /// 바닥 지도 위에 부가적인 정보를 나타내는 레이어 그룹을 활성화 할 수 있습니다.
  /// 지도의 타입마다 설정가능한 레이어 그룹이 다릅니다.
  ///
  /// ***
  /// null 인경우 [MapLayer.LAYER_GROUP_BUILDING]이 기본값으로 설정됩니다.
  ///
  /// 건물레이어를 지우고 싶으면 빈 리스트를 파라미터로 넘겨주세요.
  // final List<MapLayer> activeLayers;

  /// 지도가 기울어지면 건물이 입체적으로 표시됩니다. buildingHeight 속성을 사용하면
  /// 입체적으로 표현되는 건물의 높이를 지정할 수 있습니다.
  /// 값은 0~1의 비율로 지정할 수 있으며, 0으로 지정하면 지도가 기울어지더라도
  /// 건물이 입체적으로 표시되지 않습니다. 기본값은 1입니다.
  final double buildingHeight;

  /// 속성을 사용하면 심벌의 크기를 변경할 수 있습니다. 0~2의 비율로 지정할 수 있으며,
  /// 값이 클수록 심벌이 커집니다. 기본값은 1입니다. 0일때, 심볼이 표시되지 않습니다.
  final double symbolScale;

  /// 지도를 기울이면 가까이 있는 심벌은 크게, 멀리 있는 심벌은 작게 그려집니다.
  /// symbolPerspectiveRatio 속성을 사용하면 심벌의 원근 효과를 조절할 수 있습니다.
  /// 0~1의 비율로 지정할 수 있으며, 값이 작을수록 원근감이 줄어들어 0이 되면
  /// 원근 효과가 완전히 사라집니다. 기본값은 1입니다.
  final double symbolPerspectiveRatio;

  /// NaveraMap 최초 생성 이후,
  /// flutter에서 setState() 함수로 값을 변경해도 반영 되지 않는다.
  ///
  /// 이 속성을 이용해서 지도의 회전을 불가능하게 할 수 있다.
  /// 기본값은 true이다.
  ///
  /// [rotationGestureEnable], [scrollGestureEnable], [tiltGestureEnable],
  ///
  /// [zoomGestureEnable], [locationButtonEnable] 5가지는 초기화시에만 반영된다.
  final bool rotationGestureEnable;

  /// NaveraMap 최초 생성 이후,
  /// flutter에서 setState() 함수로 값을 변경해도 반영 되지 않는다.
  ///
  /// 이 속성을 이용해서 지도의 이동을 불가능하게 할 수 있다.
  /// 기본값은 true이다.
  final bool scrollGestureEnable;

  /// NaveraMap 최초 생성 이후,
  /// flutter에서 setState() 함수로 값을 변경해도 반영 되지 않는다.
  ///
  /// 이 속성을 이용해서 지도의 기울임을 불가능하게 할 수 있다.
  /// 기본값은 true이다.
  final bool tiltGestureEnable;

  /// NaveraMap 최초 생성 이후,
  /// flutter에서 setState() 함수로 값을 변경해도 반영 되지 않는다.
  ///
  /// 이 속성을 이용해서 지도의 확대를 불가능하게 할 수 있다.
  /// 기본값은 true이다.
  final bool zoomGestureEnable;

  /// <h2> Naver Map에서 기본적으로 제공하는 현위치 버튼을 활성화시킨다.</h2>
  /// <br/>
  /// <p>기본값은 [false]이다.</p>
  final bool locationButtonEnable;

  /// 지도에 표시될 마커의 리스트입니다.
  final List<Marker> markers;

  /// 지도에 표시될 [PathOverlay]의 [Set] 입니다..
  final Set<PathOverlay>? pathOverlays;

  /// 지도에 표시될 [CircleOverlay]의 [List]입니다.
  final List<CircleOverlay> circles;

  /// 지도에 표시될 [PolygonOverlay]의 [List]입니다.
  final List<PolygonOverlay> polygons;

  /// 지도가 더블탭될때 콜백되는 메서드. (Android only)
  final OnMapDoubleTap? onMapDoubleTap;

  /// 최초 지도 생성시에 위치추적모드를 선택할 수 있습니다.
  ///
  /// 기본값은 [LocationTrackingMode.NoFollow] 입니다.
  final LocationTrackingMode initLocationTrackingMode;

  /// 지도가 두 손가락으로 탭 되었을때 호출되는 콜백 메서드. (Android only)
  final OnMapTwoFingerTap? onMapTwoFingerTap;

  /// <h2>심볼 탭 이벤트</h2>
  /// <p>빌딩을 나타내는 심볼이나, 공공시설을 표시하는 심볼등을 선택했을 경우 호출된다.</p>
  final OnSymbolTap? onSymbolTap;
  @override
  _NaverMapState createState() => _NaverMapState();
}

class _NaverMapState extends State<NaverMap> {
  int _textureId = -1;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      final controller = NaverMapController();
      controller.initialize(widget.initialCameraPosition).then((e) {
        setState(() {
          _textureId = controller._textureId;
        });
        if (widget.onMapCreated != null) {
          if (widget.onMapTap != null) {
            controller.addEnvent(MapEventModel(
                id: "${controller._textureId}#onMapTap",
                event: MapEventEnum.onTap,
                func: widget.onMapTap));
          }

          if (widget.onMapTap != null) {
            controller.addEnvent(MapEventModel(
                id: "${controller._textureId}#onMapRightClick",
                event: MapEventEnum.onRightClick,
                func: widget.onMapRightClick));
          }

          controller.updateMarkers(widget.markers ?? []);
          controller.updatePolygon(widget.polygons ?? []);

          widget.onMapCreated(controller);
        }
      });
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _textureId = widget.controller._textureId;
  }

  @override
  Widget build(BuildContext context) {
    return _textureId == null ||
            _textureId == NaverMapController.kUninitializedTextureId
        ? Container()
        : _videoPlayerPlatform.buildView(_textureId);
  }
}

class NaverMapController {
  @visibleForTesting
  static const int kUninitializedTextureId = -1;
  int _textureId = kUninitializedTextureId;
  late Completer<void> _creatingCompleter;

  List<Marker> markers = [];
  List<PolygonOverlay> polygons = [];
  List<MapEventModel> events = [];
  LatLng? location;

  /// This is just exposed for testing. It shouldn't be used by anyone depending
  /// on the plugin.
  int get textureId => _textureId;

  initialize(initialCameraPosition) async {
    var mapOption = MapOption(initialCameraPosition: initialCameraPosition);
    _textureId = (await _videoPlayerPlatform.create(mapOption)) ??
        kUninitializedTextureId;
    print(_textureId);
  }

  addEnvent(MapEventModel evnet) {
    events.add(evnet);
    updateEvnets(events);
  }

  removeEnvet(MapEventModel evnet) {}

  removeEventByName(String id) {
    // this.value.events.add(evnet);
    // this.notifyListeners();
  }

  updateEvnets(List<MapEventModel> events) {
    if (events != this.events) {
      this.events = events;
    }
    _videoPlayerPlatform.updateEventHandler(_textureId, events);
  }

  addMarker(Marker marker) {
    this.markers.add(marker);
    _videoPlayerPlatform.updateMarker(_textureId, markers);
  }

  removeMarker(Marker marker) {}
  updateMarkers(List<Marker> markers) {
    if (markers != this.markers) {
      this.markers = markers;
    }
    _videoPlayerPlatform.updateMarker(_textureId, markers);
  }

  addPolygon(PolygonOverlay polygon) {
    this.polygons.add(polygon);
    updatePolygon(polygons);
  }

  updatePolygon(List<PolygonOverlay> polygons) {
    if (this.polygons != polygons) {
      this.polygons = polygons;
    }
    _videoPlayerPlatform.updatePolygon(_textureId, polygons);
  }
}

class NaverMapViewModel {
  // int id;

}
