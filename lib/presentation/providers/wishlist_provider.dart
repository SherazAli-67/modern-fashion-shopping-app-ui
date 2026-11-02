import 'package:flutter/foundation.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_data.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';

class WishlistProvider extends ChangeNotifier {
  int selectedFilterIndex = 0;
  late final Set<String> favoriteIds;

  WishlistProvider() {
    favoriteIds = {
      for (final product in AppData.products)
        if (product.isFavorite) product.id,
    };
  }

  List<ProductModel> get wishlistProducts {
    final favorites = AppData.products.where((product) => favoriteIds.contains(product.id)).toList();
    final filter = AppData.wishlistFilters[selectedFilterIndex];
    if (filter == StringConst.filterAll) return favorites;
    return favorites.where((product) => product.filter == filter || product.category == filter).toList();
  }

  void selectFilter(int index) {
    selectedFilterIndex = index;
    notifyListeners();
  }

  bool isFavorite(String id) => favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
    notifyListeners();
  }
}
