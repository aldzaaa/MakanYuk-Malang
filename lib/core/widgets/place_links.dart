import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../culinary/domain/models/culinary_place.dart';

final externalLinkLauncherProvider = Provider<Future<bool> Function(Uri)>(
  (ref) =>
      (uri) => launchUrl(uri, mode: LaunchMode.externalApplication),
);

class PlaceLinks extends ConsumerWidget {
  const PlaceLinks({super.key, required this.place});
  final CulinaryPlace place;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> open(Uri uri) async {
      try {
        if (!await ref.read(externalLinkLauncherProvider)(uri)) {
          throw StateError('Tautan tidak tersedia');
        }
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tautan belum dapat dibuka. Coba lagi.'),
            ),
          );
        }
      }
    }

    final google = place.googleSearchUri;
    final maps = place.mapsSearchUri;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (google != null)
          OutlinedButton.icon(
            onPressed: () => open(google),
            icon: const Icon(Icons.search, size: 17),
            label: const Text('Google'),
          ),
        FilledButton.icon(
          onPressed: maps == null ? null : () => open(maps),
          icon: const Icon(Icons.map_outlined, size: 17),
          label: const Text('Maps'),
        ),
      ],
    );
  }
}
