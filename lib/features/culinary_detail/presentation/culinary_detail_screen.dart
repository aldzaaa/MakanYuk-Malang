import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/place_links.dart';

import '../../../app/providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/culinary_widgets.dart';

class CulinaryDetailScreen extends ConsumerWidget {
  const CulinaryDetailScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(culinaryPlacesProvider)
      .when(
        loading: () => const ContentPage(
          title: 'Detail kuliner',
          children: [LoadingSkeleton()],
        ),
        error: (_, _) => ContentPage(
          title: 'Detail kuliner',
          children: [
            ErrorState(retry: () => ref.invalidate(culinaryCatalogProvider)),
          ],
        ),
        data: (places) {
          final matches = places.where((p) => p.id == id);
          if (matches.isEmpty) {
            return ContentPage(
              title: 'Detail kuliner',
              children: [
                EmptyState(
                  title: 'Kuliner tidak ditemukan',
                  message:
                      'Pilihan ini belum tersedia pada sumber data saat ini.',
                  action: FilledButton(
                    onPressed: () => context.go('/explore'),
                    child: const Text('Kembali menjelajah'),
                  ),
                ),
              ],
            );
          }
          final place = matches.first;
          final hasLocation = place.mapsSearchUri != null;
          return ContentPage(
            title: 'Cerita rasa',
            actions: [
              FavoriteButton(place: place),
              const SizedBox(width: 12),
            ],
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: FoodArtwork(place: place, height: 260),
              ),
              const SizedBox(height: 24),
              Text(
                place.category.toUpperCase(),
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                place.name,
                style: const TextStyle(
                  fontSize: 29,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              RatingDisplay(place: place),
              const SizedBox(height: 22),
              const SourceNotice(),
              const Text(
                'Tentang kuliner',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              Text(
                place.description ?? 'Deskripsi belum tersedia.',
                style: const TextStyle(height: 1.8),
              ),
              const SizedBox(height: 26),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lokasi',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(place.address),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              PlaceLinks(place: place),
              if (place.searchQuery != null)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Google/Maps membuka hasil pencarian berdasarkan nama. Periksa cabang, alamat, dan kondisi terbaru sebelum berkunjung.',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              if (!hasLocation)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Koordinat belum tersedia. Lokasi ilustrasi demo tidak dapat dibuka di peta.',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              const SizedBox(height: 24),
            ],
          );
        },
      );
}
