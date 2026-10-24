import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../culinary/data/datasources/local_json_data_source.dart';
import '../culinary/data/datasources/remote_culinary_data_source.dart';
import '../culinary/data/repositories/local_culinary_repository.dart';
import '../culinary/data/repositories/fallback_culinary_repository.dart';
import '../culinary/domain/models/culinary_place.dart';
import '../culinary/domain/models/culinary_catalog.dart';
import '../culinary/domain/repositories/culinary_repository.dart';

final culinaryRepositoryProvider = Provider<CulinaryRepository>((ref) {
  final local = LocalCulinaryRepository(LocalJsonDataSource());
  const endpoint = String.fromEnvironment('CULINARY_API_URL');
  if (endpoint.isEmpty) return local;
  final client = http.Client();
  ref.onDispose(client.close);
  return FallbackCulinaryRepository(
    local: local,
    remote: RemoteCulinaryDataSource(client: client, baseUrl: endpoint),
  );
});
final culinaryCatalogProvider = FutureProvider<CulinaryCatalog>(
  (ref) => ref.watch(culinaryRepositoryProvider).getCatalog(),
);
final culinaryPlacesProvider = FutureProvider<List<CulinaryPlace>>(
  (ref) async => (await ref.watch(culinaryCatalogProvider.future)).places,
);
