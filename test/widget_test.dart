import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:makanyuk_malang/app/app.dart';
import 'package:makanyuk_malang/app/router.dart';
import 'package:makanyuk_malang/app/providers.dart';
import 'package:makanyuk_malang/features/favorites/presentation/favorites_view_model.dart';
import 'package:makanyuk_malang/core/widgets/culinary_widgets.dart';

Future<ProviderContainer> launch(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final container = ProviderContainer();
  addTearDown(container.dispose);
  await tester.runAsync(() async {
    await container.read(culinaryPlacesProvider.future);
    await container.read(favoritesProvider.future);
  });
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const MakanYukApp()),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  testWidgets('Pencarian, detail, favorit dan missing ID bekerja', (
    tester,
  ) async {
    final container = await launch(tester);
    await tester.tap(find.text('Mulai jelajah'));
    await tester.pumpAndSettle();
    expect(find.text('20 kuliner ditemukan'), findsOneWidget);
    await tester.enterText(
      find.byType(TextField).hitTestable(),
      'Contoh Bakso',
    );
    await tester.pumpAndSettle();
    expect(find.text('1 kuliner ditemukan'), findsOneWidget);
    await tester.ensureVisible(find.byType(CulinaryCard).first);
    await tester.tap(find.byType(CulinaryCard).hitTestable().first);
    await tester.pumpAndSettle();
    expect(find.text('Contoh Bakso Malang'), findsOneWidget);
    expect(find.text('Rating belum tersedia'), findsOneWidget);
    await tester.runAsync(
      () => container.read(favoritesProvider.notifier).toggle('demo_bakso_001'),
    );
    await tester.pumpAndSettle();
    expect(
      container.read(favoritesProvider).requireValue.ids,
      contains('demo_bakso_001'),
    );
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favorit').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('1 pilihan tersimpan'), findsOneWidget);
    container.read(routerProvider).go('/culinary/tidak-ada');
    await tester.pumpAndSettle();
    expect(find.text('Kuliner tidak ditemukan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Pencarian kosong bisa direset', (tester) async {
    await launch(tester);
    await tester.tap(find.text('Mulai jelajah'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).hitTestable(), 'zzzz');
    await tester.pumpAndSettle();
    expect(find.text('0 kuliner ditemukan'), findsOneWidget);
    await tester.ensureVisible(find.text('Reset pencarian'));
    await tester.tap(find.text('Reset pencarian'));
    await tester.pumpAndSettle();
    expect(find.text('20 kuliner ditemukan'), findsOneWidget);
  });
  for (final width in [320.0, 600.0, 1100.0]) {
    testWidgets('Seluruh route tanpa overflow pada $width', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final container = await launch(tester);
      for (final route in [
        '/explore',
        '/favorites',
        '/culinary/local_bakso_president',
        '/culinary/demo_bakso_001',
      ]) {
        container.read(routerProvider).go(route);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: route);
      }
    });
  }
}
