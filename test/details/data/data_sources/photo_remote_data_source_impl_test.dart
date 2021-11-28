import 'dart:convert';
import 'dart:io';

import 'package:awesome_app_details/details/data/data_sources/photo_remote_data_source.dart';
import 'package:awesome_app_details/details/data/models/photo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  final mockClient = MockClient();
  final dataSource = PhotoRemoteDataSourceImpl(mockClient);

  setUpAll(() {
    registerFallbackValue(Uri);
  });

  test('should return PhotoModel when fetching photo details', () async {
    // arrange
    when(() => mockClient.get(Uri.parse('https://api.pexels.com/v1/photos/1'),
        headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response(
        fixture('photo.json'),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    // act
    final result = await dataSource.fetchPhoto(1);

    // assert
    verify(() => mockClient.get(
      Uri.parse('https://api.pexels.com/v1/photos/1'),
      headers: any(named: 'headers'),
    ));
    expect(result, PhotoModel.fromJson(jsonDecode(fixture('photo.json'))));
  });

  test('should throw exception when fetching photo details', () async {
    // arrange
    when(() => mockClient.get(Uri.parse('https://api.pexels.com/v1/photos/1'),
        headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 400),
    );

    // act
    final result = dataSource.fetchPhoto(1);

    // assert
    verify(() => mockClient.get(
          Uri.parse('https://api.pexels.com/v1/photos/1'),
          headers: any(named: 'headers'),
        ));
    expect(result, throwsException);
  });
}
