import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:core/failures.dart';
import 'package:dartz/dartz.dart';

abstract class PhotoRepository {
  Future<Either<Failure, Photo>> fetchPhoto(int photoId);
}
