import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../culinary/domain/models/culinary_place.dart';

class ExploreFilter {
  const ExploreFilter({this.query = '', this.category = 'Semua'});
  final String query, category;
  List<CulinaryPlace> apply(List<CulinaryPlace> places) => places
      .where(
        (p) =>
            (category == 'Semua' || p.category == category) &&
            p.name.toLowerCase().contains(query.trim().toLowerCase()),
      )
      .toList();
}

final exploreFilterProvider = NotifierProvider<ExploreViewModel, ExploreFilter>(
  ExploreViewModel.new,
);

class ExploreViewModel extends Notifier<ExploreFilter> {
  @override
  ExploreFilter build() => const ExploreFilter();
  void search(String query) =>
      state = ExploreFilter(query: query, category: state.category);
  void category(String category) =>
      state = ExploreFilter(query: state.query, category: category);
  void reset() => state = const ExploreFilter();
}
