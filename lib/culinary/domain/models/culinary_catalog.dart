import 'culinary_place.dart';

class CulinaryCatalog {
  CulinaryCatalog({
    required List<CulinaryPlace> places,
    required this.isDemo,
    required this.notice,
  }) : places = List.unmodifiable(places);
  final List<CulinaryPlace> places;
  final bool isDemo;
  final String notice;
}
