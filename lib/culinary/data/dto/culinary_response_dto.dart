import '../../domain/models/culinary_catalog.dart';
import '../../domain/models/culinary_place.dart';

class CulinaryResponseDto {
  CulinaryResponseDto._(this.catalog);
  final CulinaryCatalog catalog;
  factory CulinaryResponseDto.fromJson(Object? decoded) {
    if (decoded is! Map<String, Object?> ||
        decoded['data'] is! List ||
        decoded['isDemo'] is! bool) {
      throw const FormatException('Format respons API tidak valid.');
    }
    final isDemo = decoded['isDemo'] as bool;
    final source = decoded['source'];
    if ((isDemo && source != 'demo') ||
        (!isDemo && source != 'google_places')) {
      throw const FormatException('Label sumber data tidak konsisten.');
    }
    final raw = decoded['data'] as List;
    if (raw.length > 20) {
      throw const FormatException('API melebihi batas hasil.');
    }
    final places = raw.map((item) {
      if (item is! Map<String, Object?> || item['source'] != source) {
        throw const FormatException('Item API tidak valid.');
      }
      return CulinaryPlace.fromJson(item);
    }).toList();
    if (places.map((p) => p.id).toSet().length != places.length) {
      throw const FormatException('ID API tidak unik.');
    }
    final attribution = decoded['attributions'];
    if (attribution != null &&
        (attribution is! List || attribution.any((item) => item is! String))) {
      throw const FormatException('Atribusi API tidak valid.');
    }
    final credits = attribution is List
        ? attribution.cast<String>().join(' • ')
        : '';
    return CulinaryResponseDto._(
      CulinaryCatalog(
        places: places,
        isDemo: isDemo,
        notice: isDemo
            ? 'Data Demo dari API • Referensi lokal dan contoh fiktif, bukan data langsung.'
            : 'Google Maps${credits.isEmpty ? '' : ' • $credits'} • Data melalui API; informasi dapat berubah.',
      ),
    );
  }
}
