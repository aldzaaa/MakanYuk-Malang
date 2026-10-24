import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../culinary/domain/models/culinary_place.dart';
import '../../../core/widgets/culinary_widgets.dart';
import 'explore_view_model.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});
  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  late final controller = TextEditingController(
    text: ref.read(exploreFilterProvider).query,
  );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(exploreFilterProvider, (before, next) {
      if (controller.text != next.query) {
        controller.value = TextEditingValue(
          text: next.query,
          selection: TextSelection.collapsed(offset: next.query.length),
        );
      }
    });
    return TextField(
      controller: controller,
      onChanged: ref.read(exploreFilterProvider.notifier).search,
      decoration: InputDecoration(
        hintText: 'Cari bakso, rawon, atau kafe...',
        labelText: 'Cari kuliner',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: ref.watch(exploreFilterProvider).query.isEmpty
            ? null
            : IconButton(
                tooltip: 'Hapus pencarian',
                icon: const Icon(Icons.close),
                onPressed: () =>
                    ref.read(exploreFilterProvider.notifier).search(''),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key, required this.places});
  final List<CulinaryPlace> places;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(exploreFilterProvider).category;
    final categories = ['Semua', ...places.map((p) => p.category).toSet()];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final category in categories)
            Padding(
              padding: const EdgeInsets.only(right: 9),
              child: ChoiceChip(
                label: Text(category),
                avatar: Icon(categoryIcon(category), size: 17),
                selected: selected == category,
                showCheckmark: false,
                onSelected: (_) =>
                    ref.read(exploreFilterProvider.notifier).category(category),
              ),
            ),
        ],
      ),
    );
  }
}
