import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:places/data/model/model.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

List<Sight> filteredSights(
  Map startPosition,
  double distanceStart,
  double distanceEnd,
) {
  List<Sight> result = mocks.where((e) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((e.lat - startPosition['lat']) * p) / 2 +
        cos(startPosition['lat'] * p) *
            cos(e.lat * p) *
            (1 - cos((e.lon - startPosition['long']) * p)) /
            2;
    double distance = 12742 * asin(sqrt(a)) * 1000;

    if (distance >= distanceStart && distance <= distanceEnd) {
      return true;
    } else {
      return false;
    }
  }).toList();

  return result;
}

double getDistance(Map startPosition, Place place) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((place.lat - startPosition['lat']) * p) / 2 +
      cos(startPosition['lat'] * p) *
          cos(place.lat * p) *
          (1 - cos((place.lng - startPosition['lng']) * p)) /
          2;
  double distance = 12742 * asin(sqrt(a)) * 1000;
  return distance;
}

List<Place> sortedByDistancePlaces(Map startPosition, List<Place> places) {
  places.sort((placeOne, placeTwo) => getDistance(startPosition, placeOne)
      .compareTo(getDistance(startPosition, placeTwo)));

  return places;
}
