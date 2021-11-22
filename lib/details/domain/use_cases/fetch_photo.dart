import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/repositories/photo_repository.dart';
import 'package:core/core.dart';

class FetchPhoto extends UseCase<Photo, int> {
  FetchPhoto(PhotoRepository repository) : _repository = repository;
  final PhotoRepository _repository;

  @override
  Future<Photo> call(int params) async {
    return await _repository.fetchPhoto(params);
  }
}
