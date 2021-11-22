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

  // test('fetch details photo from remote data source', () async {
  //   when(() => mockClient.get(
  //         Uri.parse('https://api.pexels.com/v1/photos/1'),
  //       )).thenAnswer(
  //     (_) async => http.Response(
  //       fixture('photo.json'),
  //       200,
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //       },
  //     ),
  //   );
  //
  //   final dataSource = PhotoRemoteDataSourceImpl(mockClient);
  //
  //   final result = await dataSource.fetchPhoto(1);
  //
  //   expect(result, PhotoModel.fromJson(jsonDecode(fixture('photo.json'))));
  // });
}
