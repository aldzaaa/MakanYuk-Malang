import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:makanyuk_malang/culinary/domain/models/culinary_place.dart';
import 'package:makanyuk_malang/culinary/data/datasources/local_json_data_source.dart';
import 'package:makanyuk_malang/core/widgets/place_links.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    '15 referensi nyata memiliki query aman dan 5 contoh tetap terpisah',
    () async {
      final places = await LocalJsonDataSource().load();
      final references = places.where((p) => p.searchQuery != null).toList();
      expect(places.length, 20);
      expect(references.length, 15);
      for (final p in references) {
        expect(p.mapsSearchUri!.scheme, 'https');
        expect(p.mapsSearchUri!.host, 'www.google.com');
        expect(p.mapsSearchUri!.queryParameters['query'], p.searchQuery);
        expect(p.googleSearchUri!.queryParameters['q'], p.searchQuery);
      }
      expect(
        places
            .where((p) => p.id.startsWith('demo_'))
            .every((p) => p.mapsSearchUri == null),
        isTrue,
      );
    },
  );
  testWidgets('Tombol Google dan Maps membuka target yang tepat', (
    tester,
  ) async {
    const place = CulinaryPlace(
      id: 'test',
      name: 'Bakso & Mi',
      category: 'Bakso',
      address: 'Malang',
      source: CulinarySource.demo,
      searchQuery: 'Bakso & Mi Kota Malang',
    );
    final opened = <Uri>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          externalLinkLauncherProvider.overrideWithValue((uri) async {
            opened.add(uri);
            return true;
          }),
        ],
        child: const MaterialApp(
          home: Scaffold(body: PlaceLinks(place: place)),
        ),
      ),
    );
    await tester.tap(find.text('Google'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Maps'));
    await tester.pumpAndSettle();
    expect(opened, [place.googleSearchUri, place.mapsSearchUri]);
    expect(opened.first.queryParameters['q'], 'Bakso & Mi Kota Malang');
  });
  for (final throwsError in [false, true]) {
    testWidgets('Kegagalan launcher ditampilkan (exception: $throwsError)', (
      tester,
    ) async {
      const place = CulinaryPlace(
        id: 'reference',
        name: 'Bakso President',
        category: 'Bakso',
        address: 'Malang',
        source: CulinarySource.demo,
        searchQuery: 'Bakso President Kota Malang',
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            externalLinkLauncherProvider.overrideWithValue((_) async {
              if (throwsError) throw StateError('Launcher gagal');
              return false;
            }),
          ],
          child: const MaterialApp(
            home: Scaffold(body: PlaceLinks(place: place)),
          ),
        ),
      );
      await tester.tap(find.text('Maps'));
      await tester.pumpAndSettle();
      expect(
        find.text('Tautan belum dapat dibuka. Coba lagi.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }
}
