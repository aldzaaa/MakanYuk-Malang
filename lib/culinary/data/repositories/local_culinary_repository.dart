import '../../domain/models/culinary_place.dart';
import '../../domain/models/culinary_catalog.dart';
import '../../domain/repositories/culinary_repository.dart';
import '../datasources/local_json_data_source.dart';

class LocalCulinaryRepository implements CulinaryRepository {
  const LocalCulinaryRepository(this.source);
  final LocalJsonDataSource source;
  Future<List<CulinaryPlace>> getPlaces() => source.load();
  @override
  Future<CulinaryCatalog> getCatalog() async => CulinaryCatalog(
    places: await getPlaces(),
    isDemo: true,
    notice: 'Data lokal • 15 referensi kuliner dan 5 contoh fiktif berawalan Contoh. Buka Google/Maps untuk informasi terbaru; bukan data langsung.',
  );
}
