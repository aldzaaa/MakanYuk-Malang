import 'package:shared_preferences/shared_preferences.dart';

class FavoritesStore {
  FavoritesStore(this.preferences);
  final SharedPreferences preferences;
  static const key = 'makanyuk.favorite_ids.v1';

  Set<String> read() => (preferences.getStringList(key) ?? []).toSet();
  Future<void> write(Set<String> ids) async {
    if (!await preferences.setStringList(key, ids.toList()..sort())) {
      throw StateError('Favorit gagal disimpan.');
    }
  }
}
