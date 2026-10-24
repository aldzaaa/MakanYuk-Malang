import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/models/culinary_place.dart';

class LocalJsonDataSource {
  LocalJsonDataSource({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;
  final AssetBundle _bundle;

  Future<List<CulinaryPlace>> load() async {
    final decoded = jsonDecode(
      await _bundle.loadString('assets/data/culinary_seed.json'),
    );
    if (decoded is! List) {
      throw const FormatException('Data kuliner harus berupa daftar.');
    }
    final places = decoded
        .map((item) {
          if (item is! Map<String, Object?>) {
            throw const FormatException('Item tidak valid.');
          }
          final place = CulinaryPlace.fromJson(item);
          if (place.source != CulinarySource.demo) {
            throw const FormatException('Seed lokal wajib berlabel demo.');
          }
          return place;
        })
        .toList(growable: false);
    if (places.map((p) => p.id).toSet().length != places.length) {
      throw const FormatException('ID kuliner harus unik.');
    }
    return List.unmodifiable(places);
  }
}
