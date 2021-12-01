import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/use_cases/fetch_photo.dart';
import 'package:awesome_app_details/details/presentation/blocs/photo_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FetchPhotoMock extends Mock implements FetchPhoto {}

void main() {
  final fetchPhotoMock = FetchPhotoMock();
  late PhotoCubit photoCubit;

  setUp(() {
    photoCubit = PhotoCubit(fetchPhotoMock);
  });

  tearDown(() => photoCubit.close());

  test('should return PhotoStateInitial', () {
    // assert
    expect(photoCubit.state.runtimeType, PhotoInitial);
  });

  blocTest(
    'should emit PhotoLoaded when fetched photo details',
    build: () => photoCubit,
    act: (PhotoCubit cubit) {
      when(() => fetchPhotoMock.call(any()))
          .thenAnswer((_) async => Right(Photo()));

      cubit.fetchPhoto(1);
    },
    expect: () => [isA<PhotoLoaded>()],
    verify: (PhotoCubit cubit) {
      verify(() => fetchPhotoMock.call(any()));
    },
  );

  blocTest(
    'should emit FailedLoadPhoto when failed fetching photo details',
    build: () => photoCubit,
    act: (PhotoCubit cubit) {
      when(() => fetchPhotoMock.call(any()))
          .thenAnswer((_) async => Left(NoInternetFailure()));

      cubit.fetchPhoto(1);
    },
    expect: () => [isA<FailedLoadPhoto>()],
    verify: (PhotoCubit cubit) {
      verify(() => fetchPhotoMock.call(any()));
    },
  );
}
