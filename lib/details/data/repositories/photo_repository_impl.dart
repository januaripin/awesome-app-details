import 'package:awesome_app_details/details/data/data_sources/photo_remote_data_source.dart';
import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/repositories/photo_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PhotoRepositoryImpl extends PhotoRepository {
  PhotoRepositoryImpl(
    PhotoRemoteDataSource dataSource,
    InternetConnectionChecker internetConnectionChecker,
  )   : _dataSource = dataSource,
        _internetConnectionChecker = internetConnectionChecker;

  final PhotoRemoteDataSource _dataSource;
  final InternetConnectionChecker _internetConnectionChecker;

  @override
  Future<Photo> fetchPhoto(int photoId) async {
    if (!(await _internetConnectionChecker.hasConnection)) {
      return Future.error(
          'No internet connection. Please check your connection internet!');
    }

    return await _dataSource.fetchPhoto(photoId);
  }
}
