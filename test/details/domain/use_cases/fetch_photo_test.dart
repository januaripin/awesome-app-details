import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/repositories/photo_repository.dart';
import 'package:awesome_app_details/details/domain/use_cases/fetch_photo.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  final mockRepository = MockPhotoRepository();
  final useCase = FetchPhoto(mockRepository);

  test('should return Right(Photo) when fetching photo details', () async {
    // arrange
    when(() => mockRepository.fetchPhoto(1))
        .thenAnswer((_) async => Right(Photo()));

    // act
    final result = await useCase.call(1);

    // assert
    expect(result, Right(Photo()));
    verify(() => mockRepository.fetchPhoto(1));
  });

  test('should return Right(Photo) when fetching photo details', () async {
    // arrange
    when(() => mockRepository.fetchPhoto(1))
        .thenAnswer((_) async => Right(Photo()));

    // act
    final result = await useCase.call(1);

    // assert
    expect(result, Right(Photo()));
    verify(() => mockRepository.fetchPhoto(1));
  });

  test('should return Left(NoInternetFailure) when no internet connection', () async {
    // arrange
    when(() => mockRepository.fetchPhoto(1))
        .thenAnswer((_) async => Left(NoInternetFailure()));

    // act
    final result = await useCase.call(1);

    // assert
    expect(result, Left(NoInternetFailure()));
    verify(() => mockRepository.fetchPhoto(1));
  });
}
