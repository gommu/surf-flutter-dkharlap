import 'package:dio/dio.dart';
import '../model/model.dart';

class PlaceRepository {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://test-backend-flutter.surfstudio.ru',
    connectTimeout: 5000,
    receiveTimeout: 5000,
    sendTimeout: 5000,
    responseType: ResponseType.json,
    validateStatus: (status) => status < 500,
  ));

  Future<List<Place>> getPlaces({
    int count,
    int offset,
    String pageBy,
    String pageAfter,
    String pagePrior,
    List<String> sortBy,
  }) async {
    var queryParameters = {
      'count': count,
      'offset': offset,
      'pageBy': pageBy,
      'pageAfter': pageAfter,
      'pagePrior': pagePrior,
      'sortBy': sortBy,
    };
    final Map<String, dynamic> filteredParams = Map.from(queryParameters)
      ..removeWhere((key, value) => value == null);

    final response = await dio.get('/place', queryParameters: filteredParams);
    if (response.statusCode == 200) {
      var data = response.data;
      var places =
          List<Place>.from(data.map((model) => Place.fromJson(model)).toList());
      return places;
    } else {
      throw Exception(
          'getPlace() request HTTP Error, error code ${response.statusCode}');
    }
  }

  Future<Place> getPlaceById(int id) async {
    final response = await dio.get('/place/$id');
    if (response.statusCode == 200) {
      var data = response.data;
      var place = Place.fromJson(data);
      return place;
    } else {
      throw Exception(
          'getPlaceById() request HTTP Error, error code ${response.statusCode}');
    }
  }

  Future<void> getDeletePlace(int id) async {
    final response = await dio.delete('/place/$id');
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 400) {
      throw Exception('No object found');
    } else {
      throw Exception(
          'getDeletePlace() request HTTP Error, error code ${response.statusCode}');
    }
  }

  Future<Place> updatePlace(int id, Place place) async {
    var data = place.toJson();
    data.remove('id');
    final response =
        await dio.put('/place/$id', data: data);
    if (response.statusCode == 200) {
      var data = response.data;
      var place = Place.fromJson(data);
      return place;
    } else if (response.statusCode == 400) {
      throw Exception('Invalid request, message: ${response.data}');
    } else if (response.statusCode == 404) {
      throw Exception('No object found');
    } else if (response.statusCode == 409) {
      throw Exception('Object already exists');
    } else {
      throw Exception(
          'updatePlace() request HTTP Error, error code ${response.statusCode}');
    }
  }

  Future<Place> addPlace(Place place) async {
    final response =
    await dio.post('/place', data: place.toJson());
    if (response.statusCode == 200) {
      var data = response.data;
      var place = Place.fromJson(data);
      return place;
    } else if (response.statusCode == 400) {
      throw Exception('Invalid request');
    } else if (response.statusCode == 409) {
      throw Exception('Object already exists');
    } else {
      throw Exception(
          'addPlace() request HTTP Error, error code ${response.statusCode}');
    }
  }
}
