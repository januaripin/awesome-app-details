part of 'photo_cubit.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();
}

class PhotoInitial extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoaded extends PhotoState {

  PhotoLoaded(this.photo);

  final Photo photo;

  @override
  List<Object?> get props => [photo];
}

class FailedLoadPhoto extends PhotoState {
  FailedLoadPhoto(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
