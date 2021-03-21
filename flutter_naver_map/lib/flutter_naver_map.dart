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
import 'package:flutter_naver_platform_interface/message.dart';
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

class NaverMapViewModel {
  // int id;

}
