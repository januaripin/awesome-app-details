import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/use_cases/fetch_photo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit(FetchPhoto fetchPhoto)
      : _fetchPhoto = fetchPhoto,
        super(PhotoInitial());

  final FetchPhoto _fetchPhoto;

  void fetchPhoto(int photoId) async {
    await _fetchPhoto
        .call(photoId)
        .then((value) => emit(PhotoLoaded(value)))
        .catchError((error) {
          print(error);
      emit(FailedLoadPhoto(error.toString()));
    });
  }
}
