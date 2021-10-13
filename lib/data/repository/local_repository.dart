import 'package:places/data/model/model.dart';

class FavoritePlaceRepository {
  final List<Place> favoritePlaces = [];

  void addPlaceToFavorite(Place place) {
    favoritePlaces.add(place);
  }

  void deletePlaceFromFavorite(Place place) {
    favoritePlaces.removeWhere((element) => element.id == place.id);
  }
}

class VisitedPlaceRepository {
  final List<Place> visitedPlaces = [];

  void addPlaceToVisited(Place place) {
    visitedPlaces.add(place);
  }
}