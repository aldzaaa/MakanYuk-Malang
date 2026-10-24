import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/culinary_widgets.dart';
import '../../explore/presentation/explore_controls.dart';
import '../../explore/presentation/explore_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ContentPage(
    title: 'MakanYuk Malang',
    children: [
      const Row(
        children: [
          Icon(Icons.location_on, size: 17, color: AppTheme.primary),
          SizedBox(width: 6),
          Text(
            'Kota Malang',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
          Spacer(),
          Text('JAWA TIMUR', style: TextStyle(fontSize: 9, letterSpacing: 1.5)),
        ],
      ),
      const SizedBox(height: 22),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: AppTheme.ink,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CERITA RASA DARI MALANG',
              style: TextStyle(
                color: Color(0xFFE9BC8B),
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Jelajahi Rasa,\nTemukan Cerita.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                height: 1.25,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Dari semangkuk bakso hangat hingga\nsecangkir kopi untuk jeda harimu.',
              style: TextStyle(
                color: Color(0xFFE8D9C5),
                height: 1.7,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: () {
                ref.read(exploreFilterProvider.notifier).reset();
                context.go('/explore');
              },
              icon: const Icon(Icons.arrow_forward, size: 17),
              label: const Text('Mulai jelajah'),
            ),
          ],
        ),
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
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Pilihan untukmu',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/explore'),
                        child: const Text('Lihat semua'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Temukan inspirasi makan hari ini.',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  if (filtered.isEmpty)
                    EmptyState(
                      title: 'Rasa yang kamu cari belum ada',
                      message: 'Coba nama atau kategori lain.',
                      action: TextButton(
                        onPressed: () =>
                            ref.read(exploreFilterProvider.notifier).reset(),
                        child: const Text('Reset pencarian'),
                      ),
                    )
                  else
                    PlaceGrid(places: filtered.take(3).toList()),
                ],
              );
            },
          ),
    ],
  );
}
