import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/content_item.dart';

final feedProvider = StateNotifierProvider<FeedNotifier, List<ContentItem>>((ref) => FeedNotifier());

class FeedNotifier extends StateNotifier<List<ContentItem>> {
  FeedNotifier() : super([]);

  void add(ContentItem item) {
    state = [item, ...state];
  }
}
