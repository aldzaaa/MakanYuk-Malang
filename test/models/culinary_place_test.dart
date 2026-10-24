import 'package:flutter_test/flutter_test.dart';
import 'package:makanyuk_malang/culinary/domain/models/culinary_place.dart';
import 'package:makanyuk_malang/culinary/data/datasources/local_json_data_source.dart';
import 'package:makanyuk_malang/culinary/data/repositories/local_culinary_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Map<String, Object?> valid() => {
    'id': 'demo_1',
    'name': 'Contoh',
    'category': 'Bakso',
    'address': 'Ilustrasi Malang',
    'source': 'demo',
  };
  test('Model menerima field opsional null tanpa membuat rating palsu', () {
    final place = CulinaryPlace.fromJson(valid());
    expect(place.rating, isNull);
    expect(place.imageUrl, isNull);
    expect(place.source, CulinarySource.demo);
    expect(
      CulinaryPlace.fromJson({
        ...valid(),
        'rating': 4,
        'source': 'google_places',
      }).rating,
      4.0,
    );
  });
  test('Model menolak struktur dan nilai yang tidak valid', () {
    for (final invalid in [
      {...valid(), 'id': ''},
      {...valid(), 'source': 'unknown'},
      {...valid(), 'rating': 6},
      {...valid(), 'latitude': 91},
      {...valid(), 'ratingCount': -1},
      {...valid(), 'description': 42},
    ]) {
      expect(() => CulinaryPlace.fromJson(invalid), throwsFormatException);
    }
  });
  test(
    'Repository membaca asset JSON asli dengan ID unik dan label demo',
    () async {
      final places = await LocalCulinaryRepository(LocalJsonDataSource())
          .getPlaces();
      expect(places.length, 20);
      expect(places.map((p) => p.id).toSet().length, places.length);
      expect(places.every((p) => p.source == CulinarySource.demo), isTrue);
    },
  );
}
