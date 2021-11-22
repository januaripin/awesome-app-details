import 'package:awesome_app_details/details/data/data_sources/photo_remote_data_source.dart';
import 'package:awesome_app_details/details/data/models/photo_model.dart';
import 'package:awesome_app_details/details/data/models/photo_src_model.dart';
import 'package:awesome_app_details/details/data/repositories/photo_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotoRemoteDataSource extends Mock implements PhotoRemoteDataSource {}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
    final mockDataSource = MockPhotoRemoteDataSource();
    final mockInternet = MockInternetConnectionChecker();

    void runTestOnline(Function body, {bool isOnline = false}) {
        group('device is ${isOnline ? 'online' : 'offline'}', () {
            setUp(() {
                when(() => mockInternet.hasConnection).thenAnswer((_) async => isOnline);
            });

            body();
        });
    }

    runTestOnline(() {
        test('fetch details photo when online', () async {
            final photo = PhotoModel(
                id: 1,
                width: 720,
                height: 600,
                photographerId: 1,
                photographer: 'Photographer 1',
                src: const PhotoSrcModel(),
            );

            when(() => mockDataSource.fetchPhoto(1)).thenAnswer(
                    (_) async => photo,
            );

            final repository = PhotoRepositoryImpl(mockDataSource, mockInternet);

            final result = await repository.fetchPhoto(1);

            expect(result.id, equals(photo.id));
            expect(result.id, equals(photo.id));
        });
    }, isOnline: true);
}
