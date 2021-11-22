import 'package:awesome_app_details/details/domain/entities/photo.dart';

abstract class PhotoRepository {
  Future<Photo> fetchPhoto(int photoId);
}