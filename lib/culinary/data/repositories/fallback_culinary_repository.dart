import '../../domain/models/culinary_catalog.dart';
import '../../domain/repositories/culinary_repository.dart';
import '../datasources/remote_culinary_data_source.dart';

class FallbackCulinaryRepository implements CulinaryRepository {
  const FallbackCulinaryRepository({required this.remote, required this.local});
  final RemoteCulinaryDataSource remote;
  final CulinaryRepository local;
  @override
  Future<CulinaryCatalog> getCatalog() async {
    try {
      return await remote.load();
    } catch (_) {
      final demo = await local.getCatalog();
      return CulinaryCatalog(
        places: demo.places,
        isDemo: true,
        notice: 'API tidak dapat dimuat. Menggunakan Data Demo lokal • Referensi lokal dan contoh fiktif, bukan data langsung.',
      );
    }
  }
}
