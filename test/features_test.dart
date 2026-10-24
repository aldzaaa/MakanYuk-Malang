import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:makanyuk_malang/culinary/data/datasources/local_json_data_source.dart';
import 'package:makanyuk_malang/features/explore/presentation/explore_view_model.dart';
import 'package:makanyuk_malang/features/favorites/presentation/favorites_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Pencarian tidak peka kapital, kategori dan query digabung', () async {
    final places = await LocalJsonDataSource().load();
    expect(
      const ExploreFilter(query: ' cONTOH bAKSO ').apply(places).single.id,
      'demo_bakso_001',
    );
    expect(
      const ExploreFilter(
        query: 'Contoh Bakso',
        category: 'Kafe',
      ).apply(places),
      isEmpty,
    );
    expect(
      const ExploreFilter(category: 'Kafe').apply(places).single.category,
      'Kafe',
    );
  });
  test(
    'Favorit bertahan setelah viewmodel dibuat ulang dan bisa dihapus',
    () async {
      SharedPreferences.setMockInitialValues({});
      final first = ProviderContainer();
      await first.read(favoritesProvider.future);
      expect(
        await first.read(favoritesProvider.notifier).toggle('demo_bakso_001'),
        isTrue,
      );
      first.dispose();
      final second = ProviderContainer();
      addTearDown(second.dispose);
      expect(
        (await second.read(favoritesProvider.future)).ids,
        contains('demo_bakso_001'),
      );
      expect(
        await second.read(favoritesProvider.notifier).toggle('demo_bakso_001'),
        isTrue,
      );
      expect(second.read(favoritesProvider).requireValue.ids, isEmpty);
      second.invalidate(favoritesProvider);
      expect((await second.read(favoritesProvider.future)).ids, isEmpty);
    },
  );
}
