import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:makanyuk_malang/culinary/data/datasources/local_json_data_source.dart';
import 'package:makanyuk_malang/culinary/data/datasources/remote_culinary_data_source.dart';
import 'package:makanyuk_malang/culinary/data/repositories/local_culinary_repository.dart';
import 'package:makanyuk_malang/culinary/data/repositories/fallback_culinary_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final item = <String, Object?>{
    'id': 'remote_1',
    'name': 'Contoh API',
    'category': 'Bakso',
    'address': 'Malang',
    'source': 'google_places',
  };
  test('HTTP ke kontrak API dipetakan ke model typed', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/api/v1/culinary');
      expect(request.url.queryParameters['limit'], '20');
      return http.Response(
        jsonEncode({
          'data': [item],
          'source': 'google_places',
          'isDemo': false,
        }),
        200,
      );
    });
    addTearDown(client.close);
    final data = await RemoteCulinaryDataSource(
      client: client,
      baseUrl: 'https://example.com',
    ).load();
    expect(data.isDemo, isFalse);
    expect(data.places.single.id, 'remote_1');
    expect(data.notice, contains('Google Maps'));
  });
  for (final failure in ['status', 'malformed', 'source', 'network']) {
    test('Kegagalan $failure fallback transparan ke JSON lokal', () async {
      final client = MockClient((request) async {
        if (failure == 'network') throw http.ClientException('offline');
        if (failure == 'status') return http.Response('{}', 503);
        if (failure == 'source') {
          return http.Response(
            jsonEncode({
              'data': [item],
              'source': 'demo',
              'isDemo': true,
            }),
            200,
          );
        }
        return http.Response('{broken', 200);
      });
      addTearDown(client.close);
      final repository = FallbackCulinaryRepository(
        local: LocalCulinaryRepository(LocalJsonDataSource()),
        remote: RemoteCulinaryDataSource(
          client: client,
          baseUrl: 'https://example.com',
        ),
      );
      final catalog = await repository.getCatalog();
      expect(catalog.isDemo, isTrue);
      expect(catalog.places.length, 20);
      expect(catalog.notice, contains('API tidak dapat dimuat'));
    });
  }
  test('URL HTTP publik ditolak sebelum request', () async {
    final client = MockClient(
      (_) async => throw StateError('Tidak boleh dipanggil'),
    );
    addTearDown(client.close);
    expect(
      RemoteCulinaryDataSource(
        client: client,
        baseUrl: 'http://example.com',
      ).load(),
      throwsFormatException,
    );
  });
}
