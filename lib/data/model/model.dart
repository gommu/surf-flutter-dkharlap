class Place {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  Place({
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.urls,
    this.placeType,
    this.description,
  });

  @override
  String toString() {
    return 'Place{' +
        ' id: $id,' +
        ' lat: $lat,' +
        ' lng: $lng,' +
        ' name: $name,' +
        ' urls: $urls,' +
        ' placeType: $placeType,' +
        ' description: $description,' +
        '}';
  }

  Place copyWith({
    int id,
    double lat,
    double lng,
    String name,
    List<String> urls,
    String placeType,
    String description,
  }) {
    return Place(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      urls: urls ?? this.urls,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
    );
  }

  factory Place.fromJson(Map<String, dynamic> json) {

    List<String> urls = [];

    if (json['urls'] != null) {
      var jsonUrls = json['urls'] as List;
      urls = jsonUrls.map((url) => url.toString()).toList();
    }

    return  Place(
      id: json['id'],
      lat: json['lat'],
      lng: json['lng'],
      name: json['name'],
      urls: urls,
      placeType: json['placeType'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'lat': lat,
    'lng': lng,
    'name': name,
    'urls': urls,
    'placeType': placeType,
    'description': description,
  };
}
