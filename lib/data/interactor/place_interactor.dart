import 'package:places/ui/screen/res/utils.dart';

import '../model/model.dart';
import '../repository/network_repository.dart';
import '../repository/local_repository.dart';


class PlaceInteractor {
  final networkRepository = PlaceRepository();
  final favoritePlacesRepository = FavoritePlaceRepository();
  final visitedPlacesRepository = VisitedPlaceRepository();

  final _startPosition = {'lng': 27.55, 'lat': 53.90};

  // Static instance before using DI
  static final PlaceInteractor _placeInteractor = PlaceInteractor._internal();

  factory PlaceInteractor() {
    return _placeInteractor;
  }

  PlaceInteractor._internal();

  /// List of places filtered by distance from user
  Future<List<Place>> getPlaces({int radius, String category}) async {
    var places = await networkRepository.getPlaces();
    return sortedByDistancePlaces(_startPosition, places);

  }

  /// Returns place details
  Future<Place> getPlaceDetails(int id) async {
    var place = await networkRepository.getPlaceById(id);
    return place;
  }

  /// List of favorite places sorted by distance from user
  List<Place> getFavoritePlaces() {
    return favoritePlacesRepository.favoritePlaces;
  }

  /// Add place to favorites
  void addToFavorites(Place place) {
    favoritePlacesRepository.addPlaceToFavorite(place);
  }

  /// Remove place from favorites
  void removeFromFavorites(Place place) {
    favoritePlacesRepository.deletePlaceFromFavorite(place);
  }

  /// Returns visited places
  List<Place> getVisitPlaces() {
    return visitedPlacesRepository.visitedPlaces;
  }

  /// Add place to visited places list
  void addToVisitingPlaces(Place place) {
    visitedPlacesRepository.addPlaceToVisited(place);
  }

  /// Add new place
  Future<Place> addNewPlace(Place place) async {
    return await networkRepository.addPlace(place);
  }
}