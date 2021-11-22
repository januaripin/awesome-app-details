import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/entities/photo_src.dart';
import 'package:awesome_app_details/details/domain/repositories/photo_repository.dart';
import 'package:awesome_app_details/details/domain/use_cases/fetch_photo.dart';
import 'package:core/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  final mockRepository = MockPhotoRepository();

  test('fetch photos use case', () async {
    final useCase = FetchPhoto(mockRepository);

    final photo = Photo(
      id: 1,
      width: 720,
      height: 600,
      photographerId: 1,
      photographer: 'Photographer 1',
      src: const PhotoSrc(),
    );

    when(() => mockRepository.fetchPhoto(1)).thenAnswer((_) async => photo);

    final result = await useCase.call(1);

    expect(result.id, photo.id);
    expect(result.id, photo.id);
  });

  test('should throw exception', () async {
    when(() => mockRepository.fetchPhoto(1)).thenAnswer((_) async => throw NoConnectionException());

    final useCase = FetchPhoto(mockRepository);
    expect(useCase.call(1), throwsException);
  });
}
