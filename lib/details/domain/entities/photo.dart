import 'photo_src.dart';
import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  const Photo({
    this.id = 0,
    this.width = 0,
    this.height = 0,
    this.photographerId = 0,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.avgColor,
    this.src = const PhotoSrc(),
    this.liked = false,
  });

  final int id;
  final int width;
  final int height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int photographerId;
  final String? avgColor;
  final PhotoSrc src;
  final bool liked;

  @override
  List<Object?> get props => [id];
}
