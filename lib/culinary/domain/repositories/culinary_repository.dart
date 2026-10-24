import '../models/culinary_catalog.dart';

abstract interface class CulinaryRepository {
  Future<CulinaryCatalog> getCatalog();
}
