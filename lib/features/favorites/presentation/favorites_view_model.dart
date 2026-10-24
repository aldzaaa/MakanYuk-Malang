import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/favorites_store.dart';

final favoritesStoreProvider = FutureProvider<FavoritesStore>((ref) async {
  return FavoritesStore(await SharedPreferences.getInstance());
});

class FavoritesState {
  FavoritesState(Set<String> ids, {this.saving = false})
    : ids = Set.unmodifiable(ids);
  final Set<String> ids;
  final bool saving;
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesViewModel, FavoritesState>(
      FavoritesViewModel.new,
    );

class FavoritesViewModel extends AsyncNotifier<FavoritesState> {
  @override
  Future<FavoritesState> build() async =>
      FavoritesState((await ref.watch(favoritesStoreProvider.future)).read());

  Future<bool> toggle(String id) async {
    final before = state.asData?.value;
    if (before == null || before.saving) return false;
    state = AsyncData(FavoritesState(before.ids, saving: true));
    final next = {...before.ids};
    if (!next.add(id)) next.remove(id);
    try {
      await (await ref.read(favoritesStoreProvider.future)).write(next);
      if (ref.mounted) state = AsyncData(FavoritesState(next));
      return true;
    } catch (_) {
      if (ref.mounted) state = AsyncData(before);
      return false;
    }
  }
}
