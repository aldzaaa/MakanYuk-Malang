import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/culinary_widgets.dart';
import 'explore_controls.dart';
import 'explore_view_model.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ContentPage(
    title: 'Eksplor kuliner',
    actions: [
      IconButton(
        tooltip: 'Muat ulang kuliner',
        onPressed: () => ref.invalidate(culinaryCatalogProvider),
        icon: const Icon(Icons.refresh),
      ),
    ],
    children: [
      const Text(
        'Mau makan apa\nhari ini?',
        style: TextStyle(
          fontSize: 30,
          height: 1.3,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Telusuri cerita rasa di setiap sudut Malang.',
        style: TextStyle(fontSize: 12),
      ),
      const SizedBox(height: 24),
      const SearchField(),
      const SizedBox(height: 18),
      ref
          .watch(culinaryPlacesProvider)
          .when(
            loading: () => const LoadingSkeleton(),
            error: (_, _) => ErrorState(
              retry: () => ref.invalidate(culinaryCatalogProvider),
            ),
            data: (places) {
              final filtered = ref.watch(exploreFilterProvider).apply(places);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryChips(places: places),
                  const SizedBox(height: 22),
                  const SourceNotice(),
                  Text(
                    '${filtered.length} kuliner ditemukan',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 18),
                  if (filtered.isEmpty)
                    EmptyState(
                      title: 'Belum ketemu yang pas',
                      message: 'Ubah kata kunci atau kategori pilihanmu.',
                      action: FilledButton(
                        onPressed: () =>
                            ref.read(exploreFilterProvider.notifier).reset(),
                        child: const Text('Reset pencarian'),
                      ),
                    )
                  else
                    PlaceGrid(places: filtered),
                ],
              );
            },
          ),
    ],
  );
}
