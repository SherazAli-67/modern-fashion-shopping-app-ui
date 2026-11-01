class ProductModel {
  final String id;
  final String brand;
  final String category;
  final double price;
  final double? oldPrice;
  final String image;
  final List<String> gallery;
  final String description;
  final List<String> colors;
  final List<String> sizes;
  final bool isFavorite;
  final String filter;

  const ProductModel({
    required this.id,
    required this.brand,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.image,
    required this.gallery,
    required this.description,
    required this.colors,
    required this.sizes,
    this.isFavorite = false,
    required this.filter,
  });

  ProductModel copyWith({bool? isFavorite}) => ProductModel(
        id: id,
        brand: brand,
        category: category,
        price: price,
        oldPrice: oldPrice,
        image: image,
        gallery: gallery,
        description: description,
        colors: colors,
        sizes: sizes,
        isFavorite: isFavorite ?? this.isFavorite,
        filter: filter,
      );
}
