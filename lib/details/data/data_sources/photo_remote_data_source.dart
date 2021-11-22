import 'package:awesome_app_details/details/data/models/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<PhotoModel> fetchPhoto(int photoId);
}