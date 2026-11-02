import 'package:flutter/foundation.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_data.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  int selectedFilterIndex = 0;
  int selectedCategoryIndex = 0;
  late final Set<String> favoriteIds;

  HomeProvider() {
    favoriteIds = {
      for (final product in AppData.products)
        if (product.isFavorite) product.id,
    };
  }

  List<ProductModel> get filteredProducts {
    final filter = AppData.filters[selectedFilterIndex];
    if (filter == StringConst.filterAll) return AppData.products;
    return AppData.products.where((product) => product.filter == filter || product.category == filter).toList();
  }

  void selectFilter(int index) {
    selectedFilterIndex = index;
    notifyListeners();
  }

  void selectCategory(int index) {
    selectedCategoryIndex = index;
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
