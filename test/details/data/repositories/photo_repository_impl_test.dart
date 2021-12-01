import 'package:awesome_app_details/details/data/data_sources/photo_remote_data_source.dart';
import 'package:awesome_app_details/details/data/models/photo_model.dart';
import 'package:awesome_app_details/details/data/repositories/photo_repository_impl.dart';
import 'package:core/core.dart';
import 'package:core/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotoRemoteDataSource extends Mock implements PhotoRemoteDataSource {}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  final mockDataSource = MockPhotoRemoteDataSource();
  final mockInternet = MockInternetConnectionChecker();
  final repository = PhotoRepositoryImpl(mockDataSource, mockInternet);

  void runTestOnline(Function body, {bool isOnline = false}) {
    group('device is ${isOnline ? 'online' : 'offline'}, ', () {
      setUp(() {
        when(() => mockInternet.hasConnection)
            .thenAnswer((_) async => isOnline);
      });

      body();
    });
  }

  runTestOnline(() {
    test('should return Right(PhotoModel) when fetching photo details', () async {
      // arrange
      when(() => mockDataSource.fetchPhoto(1))
          .thenAnswer((_) async => PhotoModel());

      // act
      final result = await repository.fetchPhoto(1);

      // assert
      expect(result, Right(PhotoModel()));
      verify(() => mockDataSource.fetchPhoto(1)).called(1);
    });
  }, isOnline: true);

  runTestOnline(() {
    test('should return Left(ServerFailure) when fetching photo details', () async {
      // arrange
      when(() => mockDataSource.fetchPhoto(1)).thenAnswer((_) async =>
          throw ServerException(code: 400, message: 'Something went wrong'));

      // act
      final result = await repository.fetchPhoto(1);

      // assert
      verify(() => mockDataSource.fetchPhoto(1)).called(1);
      expect(result, Left(ServerFailure()));
    });
  }, isOnline: true);

  runTestOnline(() {
    test('should return Left(NoInternetFailure) when device offline', () async {
      // arrange
      when(() => mockDataSource.fetchPhoto(1)).thenAnswer(
        (_) async => PhotoModel(),
      );

      // act
      final result = await repository.fetchPhoto(1);

      // assert
      expect(result, Left(NoInternetFailure()));
      verifyNever(() => mockDataSource.fetchPhoto(1));
    });
  }, isOnline: false);
}
