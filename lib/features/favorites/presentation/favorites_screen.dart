import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/culinary_widgets.dart';
import 'favorites_view_model.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ContentPage(
    title: 'Favoritmu',
    children: [
      const Text(
        'Rasa yang ingin\nkamu temui lagi.',
        style: TextStyle(
          fontSize: 30,
          height: 1.3,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 14),
      const Text(
        'Pilihanmu tersimpan di perangkat ini.',
        style: TextStyle(fontSize: 12),
      ),
      const SizedBox(height: 24),
      ref
          .watch(favoritesProvider)
          .when(
            loading: () => const LoadingSkeleton(),
            error: (_, _) => ErrorState(
              retry: () {
                ref.invalidate(favoritesStoreProvider);
                ref.invalidate(favoritesProvider);
              },
            ),
            data: (favorites) => ref
                .watch(culinaryPlacesProvider)
                .when(
                  loading: () => const LoadingSkeleton(),
                  error: (_, _) => ErrorState(
                    retry: () => ref.invalidate(culinaryCatalogProvider),
                  ),
                  data: (places) {
                    final saved = places
                        .where((p) => favorites.ids.contains(p.id))
                        .toList();
                    final missing = favorites.ids.difference(
                      places.map((p) => p.id).toSet(),
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SourceNotice(),
                        if (missing.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Text(
                              '${missing.length} favorit belum tersedia pada sumber data saat ini. Pilihan tersebut tetap tersimpan.',
                            ),
                          ),
                        if (saved.isEmpty)
                          EmptyState(
                            title: 'Belum ada favorit di sini',
                            message: 'Ketuk ikon hati pada kuliner yang menarik perhatianmu.',
                            icon: Icons.favorite_border,
                            action: FilledButton(
                              onPressed: () => context.go('/explore'),
                              child: const Text('Jelajahi kuliner'),
                            ),
                          )
                        else ...[
                          Text(
                            '${saved.length} pilihan tersimpan',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 18),
                          PlaceGrid(places: saved),
                        ],
                      ],
                    );
                  },
                ),
          ),
    ],
  );
}
