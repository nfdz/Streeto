import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:path/path.dart' as Path;
import 'package:streeto/common/constants.dart';

const Duration kCacheMaxAgeDuration = const Duration(days: 7);
const int kCacheMaxImgs = 200;

class FadeInCachedImage extends FadeInImage {
  FadeInCachedImage({
    Key key,
    @required Uint8List placeholder,
    @required String image,
    double placeholderScale = 1.0,
    double imageScale = 1.0,
    bool excludeFromSemantics = false,
    String imageSemanticLabel,
    Duration fadeOutDuration = kFadeImageDuration,
    Curve fadeOutCurve = Curves.easeOut,
    Duration fadeInDuration = kFadeImageDuration,
    Curve fadeInCurve = Curves.easeIn,
    double width,
    double height,
    BoxFit fit,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
  }) : super(
          key: key,
          placeholder: MemoryImage(placeholder, scale: placeholderScale),
          image: CachedImgProvider(image, scale: imageScale),
          excludeFromSemantics: excludeFromSemantics,
          imageSemanticLabel: imageSemanticLabel,
          fadeOutDuration: fadeOutDuration,
          fadeOutCurve: fadeOutCurve,
          fadeInDuration: fadeInDuration,
          fadeInCurve: fadeInCurve,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
        );
}

class CachedImgProvider extends CachedNetworkImageProvider {
  CachedImgProvider(
    String url, {
    double scale: 1.0,
    ErrorListener errorListener,
    Map<String, String> headers,
  }) : super(
          url,
          cacheManager: ImgCacheManager(),
          scale: scale,
          errorListener: errorListener,
        );
}

class ImgCacheManager extends BaseCacheManager {
  static const key = "cached_images_data";

  static ImgCacheManager _instance;

  factory ImgCacheManager() {
    if (_instance == null) {
      _instance = ImgCacheManager._();
    }
    return _instance;
  }

  ImgCacheManager._()
      : super(
          key,
          maxAgeCacheObject: kCacheMaxAgeDuration,
          maxNrOfCacheObjects: kCacheMaxImgs,
        );

  Future<String> getFilePath() async {
    var directory = await PathProvider.getTemporaryDirectory();
    return Path.join(directory.path, key);
  }
}
