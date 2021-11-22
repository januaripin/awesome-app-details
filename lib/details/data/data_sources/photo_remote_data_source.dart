import 'dart:convert';

import 'package:awesome_app_details/details/data/models/photo_model.dart';
import 'package:core/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class PhotoRemoteDataSource {
  Future<PhotoModel> fetchPhoto(int photoId);
}

class PhotoRemoteDataSourceImpl extends PhotoRemoteDataSource {
  PhotoRemoteDataSourceImpl(http.Client client) : _client = client;

  final http.Client _client;

  @override
  Future<PhotoModel> fetchPhoto(int photoId) async {
    final response = await await _client
        .get(Uri.parse('https://api.pexels.com/v1/photos/$photoId'), headers: {
      'Authorization':
          '563492ad6f91700001000001d2da54bce6e340e7bea126e210105083'
    });

    if (response.statusCode == 200) {
      return PhotoModel.fromJson(jsonDecode(response.body));
    } else {
      print(photoId);
      throw ServerException(code: response.statusCode, message: response.body);
    }
  }
}
