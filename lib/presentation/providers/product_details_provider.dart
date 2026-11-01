import 'package:flutter/foundation.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductModel product;
  int selectedImageIndex = 0;
  int selectedColorIndex = 0;
  int selectedSizeIndex = 0;
  bool isDescriptionExpanded = false;

  ProductDetailsProvider(this.product);

  List<String> get gallery => product.gallery.isEmpty ? [product.image] : product.gallery;

  String get selectedImage => gallery[selectedImageIndex];

  String get selectedColor => product.colors[selectedColorIndex];

  String get selectedSize => product.sizes[selectedSizeIndex];

  void selectImage(int index) {
    selectedImageIndex = index;
    notifyListeners();
  }

  void selectNextColor() {
    selectedColorIndex = (selectedColorIndex + 1) % product.colors.length;
    notifyListeners();
  }

  void selectNextSize() {
    selectedSizeIndex = (selectedSizeIndex + 1) % product.sizes.length;
    notifyListeners();
  }

  void toggleDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;
    notifyListeners();
  }
}
