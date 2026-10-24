enum CulinarySource { demo, googlePlaces }

class CulinaryPlace {
  const CulinaryPlace({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.source,
    this.description,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.rating,
    this.ratingCount,
    this.searchQuery,
  });

  final String id, name, category, address;
  final String? description, imageUrl, searchQuery;
  final double? latitude, longitude, rating;
  final int? ratingCount;
  final CulinarySource source;

  Uri? get googleSearchUri => searchQuery == null
      ? null
      : Uri.https('www.google.com', '/search', {'q': searchQuery!});
  Uri? get mapsSearchUri {
    final query = latitude != null && longitude != null
        ? '$latitude,$longitude'
        : searchQuery;
    return query == null
        ? null
        : Uri.https('www.google.com', '/maps/search/', {
            'api': '1',
            'query': query,
          });
  }

  factory CulinaryPlace.fromJson(Map<String, Object?> json) {
    String requiredText(String key) {
      final value = json[key];
      if (value is! String || value.trim().isEmpty) {
        throw FormatException('Kolom $key wajib berupa teks tidak kosong.');
      }
      return value.trim();
    }

    String? optionalText(String key) {
      final value = json[key];
      if (value == null) return null;
      if (value is! String) {
        throw FormatException('Kolom $key harus berupa teks.');
      }
      return value.trim().isEmpty ? null : value.trim();
    }

    double? number(String key, double min, double max) {
      final value = json[key];
      if (value == null) return null;
      if (value is! num || !value.isFinite || value < min || value > max) {
        throw FormatException('Kolom $key di luar rentang.');
      }
      return value.toDouble();
    }

    final source = switch (json['source']) {
      'demo' => CulinarySource.demo,
      'google_places' => CulinarySource.googlePlaces,
      _ => throw const FormatException('Sumber data tidak dikenal.'),
    };
    final count = json['ratingCount'];
    if (count != null && (count is! int || count < 0)) {
      throw const FormatException('Jumlah rating tidak valid.');
    }
    return CulinaryPlace(
      id: requiredText('id'),
      name: requiredText('name'),
      category: requiredText('category'),
      address: requiredText('address'),
      source: source,
      description: optionalText('description'),
      imageUrl: optionalText('imageUrl'),
      searchQuery: optionalText('searchQuery'),
      latitude: number('latitude', -90, 90),
      longitude: number('longitude', -180, 180),
      rating: number('rating', 0, 5),
      ratingCount: count as int?,
    );
  }
}
