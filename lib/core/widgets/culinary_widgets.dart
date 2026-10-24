import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../culinary/domain/models/culinary_place.dart';
import '../../features/favorites/presentation/favorites_view_model.dart';
import '../theme/app_theme.dart';
import 'place_links.dart';

IconData categoryIcon(String category) => switch (category) {
  'Bakso' => Icons.ramen_dining,
  'Rawon' || 'Soto' => Icons.soup_kitchen_outlined,
  'Kafe' => Icons.local_cafe_outlined,
  'Jajanan' => Icons.bakery_dining_outlined,
  _ => Icons.restaurant_outlined,
};

class FoodArtwork extends StatelessWidget {
  const FoodArtwork({super.key, required this.place, this.height = 170});
  final CulinaryPlace place;
  final double height;
  @override
  Widget build(BuildContext context) {
    final art = Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: place.category == 'Kafe'
              ? [const Color(0xFFD8E2D2), const Color(0xFFB8CBB0)]
              : [const Color(0xFFF6DFC1), const Color(0xFFE9BC8B)],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -25,
            top: -45,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .18),
              ),
            ),
          ),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: .65),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withValues(alpha: .12),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Icon(
              categoryIcon(place.category),
              size: 57,
              color: const Color(0xFF72503A),
            ),
          ),
          const Positioned(
            bottom: 10,
            right: 12,
            child: Text(
              'ILUSTRASI KULINER',
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.5,
                color: Color(0xFF72503A),
              ),
            ),
          ),
        ],
      ),
    );
    if (place.imageUrl == null) return art;
    return Image.network(
      place.imageUrl!,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => art,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : art,
    );
  }
}

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.place});
  final CulinaryPlace place;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final data = favorites.asData?.value;
    final selected = data?.ids.contains(place.id) ?? false;
    return IconButton.filledTonal(
      tooltip: selected ? 'Hapus dari favorit' : 'Simpan ke favorit',
      isSelected: selected,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primary,
      ),
      onPressed: data == null || data.saving
          ? null
          : () async {
              final ok = await ref
                  .read(favoritesProvider.notifier)
                  .toggle(place.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      ok
                          ? (selected
                                ? 'Dihapus dari favorit'
                                : 'Disimpan ke favorit')
                          : 'Favorit gagal disimpan. Coba lagi.',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
      icon: Icon(selected ? Icons.favorite : Icons.favorite_border),
    );
  }
}

class CulinaryCard extends StatelessWidget {
  const CulinaryCard({super.key, required this.place});
  final CulinaryPlace place;
  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => context.push('/culinary/${Uri.encodeComponent(place.id)}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              FoodArtwork(place: place),
              Positioned(
                top: 10,
                right: 10,
                child: FavoriteButton(place: place),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.category.toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 10,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  place.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 15),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        place.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: RatingDisplay(place: place)),
                    const Icon(
                      Icons.arrow_outward,
                      size: 18,
                      color: AppTheme.primary,
                    ),
                  ],
                ),
                if (place.searchQuery != null) ...[
                  const SizedBox(height: 14),
                  PlaceLinks(place: place),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class RatingDisplay extends StatelessWidget {
  const RatingDisplay({super.key, required this.place});
  final CulinaryPlace place;
  @override
  Widget build(BuildContext context) => Text(
    place.rating == null
        ? 'Rating belum tersedia'
        : '★ ${place.rating!.toStringAsFixed(1)}${place.ratingCount == null ? '' : ' (${place.ratingCount})'}',
    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
  );
}

class PlaceGrid extends StatelessWidget {
  const PlaceGrid({super.key, required this.places});
  final List<CulinaryPlace> places;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = constraints.maxWidth >= 820
          ? 3
          : constraints.maxWidth >= 540
          ? 2
          : 1;
      final width = (constraints.maxWidth - 18 * (columns - 1)) / columns;
      return Wrap(
        spacing: 18,
        runSpacing: 18,
        children: [
          for (final place in places)
            SizedBox(
              width: width,
              child: CulinaryCard(place: place),
            ),
        ],
      );
    },
  );
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.action,
    this.icon = Icons.search_off,
  });
  final String title, message;
  final Widget? action;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(icon, size: 54, color: AppTheme.primary),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(message, textAlign: TextAlign.center),
          if (action != null)
            Padding(padding: const EdgeInsets.only(top: 18), child: action!),
        ],
      ),
    ),
  );
}

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const LinearProgressIndicator(semanticsLabel: 'Memuat kuliner'),
      const SizedBox(height: 20),
      for (var i = 0; i < 2; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: .4),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
    ],
  );
}

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.retry});
  final VoidCallback retry;
  @override
  Widget build(BuildContext context) => EmptyState(
    title: 'Kuliner belum bisa dimuat',
    message: 'Periksa koneksi atau coba kembali sebentar lagi.',
    icon: Icons.wifi_off_outlined,
    action: FilledButton(onPressed: retry, child: const Text('Coba lagi')),
  );
}

class SourceNotice extends ConsumerWidget {
  const SourceNotice({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(culinaryCatalogProvider).asData?.value;
    if (catalog == null) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6EBDD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            catalog.isDemo ? Icons.science_outlined : Icons.verified_outlined,
            size: 19,
            color: AppTheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              catalog.notice,
              style: const TextStyle(fontSize: 11, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentPage extends StatelessWidget {
  const ContentPage({
    super.key,
    required this.title,
    required this.children,
    this.actions,
  });
  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      ),
      actions: actions,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ),
    ),
  );
}
