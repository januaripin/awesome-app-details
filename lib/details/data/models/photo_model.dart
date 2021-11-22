
import 'package:awesome_app_details/details/domain/entities/photo.dart';

import 'photo_src_model.dart';

class PhotoModel extends Photo {
  PhotoModel({
    required int id,
    required int width,
    required int height,
    String? url,
    String? photographer,
    String? photographerUrl,
    required int photographerId,
    String? avgColor,
    PhotoSrcModel src = const PhotoSrcModel(),
    bool liked = false,
  }) : super(
          id: 0,
          width: 0,
          height: 0,
          photographerId: 0,
          url: url,
          photographer: photographer,
          photographerUrl: photographerUrl,
          avgColor: avgColor,
          src: src,
          liked: liked,
        );

  factory PhotoModel.fromJson(json) {
    return PhotoModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'],
      avgColor: json['avg_color'],
      src: json['src'] != null
          ? PhotoSrcModel.fromJson(json['src'])
          : PhotoSrcModel(),
      liked: json['liked'],
    );
  }
}
