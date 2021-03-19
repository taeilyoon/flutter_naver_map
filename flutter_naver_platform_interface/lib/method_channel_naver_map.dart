import 'package:flutter_naver_platform_interface/naver_map_api.dart';
import 'package:flutter_naver_platform_interface/naver_map_platform_interface.dart';

import 'message.dart';

class MethodChannelNaverMap extends NaverMapPlatform {
  NaverMapApi _api = NaverMapApi();

  @override
  Future<void> init() {
    return _api.initialize();
  }

  @override
  Future<void> dispose(int textureId) {
    return _api.dispose(TextureMessage()..textureId = textureId);
  }

  @override
  Future<int?> create(MapOption option) async {
    CreateMessage message = CreateMessage();

    TextureMessage response = await _api.create(message);
    return response.textureId;
  }
}
