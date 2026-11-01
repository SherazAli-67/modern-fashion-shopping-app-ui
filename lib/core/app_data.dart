import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/core/models/category_model.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';

class AppData {
  static const productDescription =
      "Lorem Ipsum is simply dummy text of the prin and typesetting industry. Lorem Ipsum has been the industry's standard ";

  static const filters = [
    StringConst.filterAll,
    StringConst.filterNewest,
    StringConst.filterSale,
    StringConst.filterPopular,
    StringConst.filterMan,
    StringConst.filterWoman,
    StringConst.filterKids,
  ];

  static const wishlistFilters = [
    StringConst.filterAll,
    StringConst.filterSale,
    StringConst.filterPopular,
    StringConst.filterMan,
    StringConst.filterWoman,
    StringConst.filterKids,
  ];

  static const categories = [
    CategoryModel(id: 'cat_tshirt', name: StringConst.categoryTshirt, image: AssetRes.categoryTshirt),
    CategoryModel(id: 'cat_pant', name: StringConst.categoryPant, image: AssetRes.categoryPant),
    CategoryModel(id: 'cat_dress', name: StringConst.categoryDress, image: AssetRes.categoryDress),
    CategoryModel(id: 'cat_jacket', name: StringConst.categoryJacket, image: AssetRes.categoryJacket),
    CategoryModel(id: 'cat_shoes', name: StringConst.categoryShoes, image: AssetRes.categoryShoes),
  ];

  static const products = [
    ProductModel(
      id: 'p_london_hills',
      brand: 'London Hills',
      category: 'Woman',
      price: 26,
      image: AssetRes.productLondonHills,
      gallery: [AssetRes.productLondonHills],
      description: productDescription,
      colors: ['#121818', '#DD6040', '#FFFFFF'],
      sizes: ['S', 'M', 'L', 'XL'],
      isFavorite: true,
      filter: StringConst.filterNewest,
    ),
    ProductModel(
      id: 'p_american_crew',
      brand: 'AMERICAN CREW',
      category: 'Man',
      price: 50,
      image: AssetRes.productAmericanCrew,
      gallery: [AssetRes.productAmericanCrew],
      description: productDescription,
      colors: ['#FFFFFF', '#121818'],
      sizes: ['M', 'L', 'XL'],
      isFavorite: true,
      filter: StringConst.filterPopular,
    ),
    ProductModel(
      id: 'p_bullmer',
      brand: 'BULLMER',
      category: 'Man',
      price: 40,
      image: AssetRes.productBullmer,
      gallery: [AssetRes.productBullmer],
      description: productDescription,
      colors: ['#121818', '#808080'],
      sizes: ['S', 'M', 'L', 'XL'],
      isFavorite: true,
      filter: StringConst.filterMan,
    ),
    ProductModel(
      id: 'p_juneberry',
      brand: 'JUNEBERRY',
      category: 'Woman',
      price: 50,
      oldPrice: 62,
      image: AssetRes.productJuneberry,
      gallery: [
        AssetRes.galleryJuneberry1,
        AssetRes.galleryJuneberry2,
        AssetRes.galleryJuneberry3,
        AssetRes.galleryJuneberry4,
      ],
      description: productDescription,
      colors: ['#121818', '#DD6040'],
      sizes: ['S', 'M', 'L', 'XL'],
      isFavorite: true,
      filter: StringConst.filterSale,
    ),
    ProductModel(
      id: 'p_fun_fashion',
      brand: 'FUN FASHION',
      category: 'Woman',
      price: 40,
      image: AssetRes.productFunFashion,
      gallery: [AssetRes.productFunFashion],
      description: productDescription,
      colors: ['#FFFFFF', '#DD6040'],
      sizes: ['S', 'M', 'L'],
      isFavorite: false,
      filter: StringConst.filterWoman,
    ),
    ProductModel(
      id: 'p_van_heusen',
      brand: 'Van Heusen',
      category: 'Woman',
      price: 40,
      image: AssetRes.productVanHeusen,
      gallery: [AssetRes.productVanHeusen],
      description: productDescription,
      colors: ['#FFFFFF', '#808080'],
      sizes: ['S', 'M', 'L', 'XL'],
      isFavorite: true,
      filter: StringConst.filterNewest,
    ),
    ProductModel(
      id: 'p_peter_england',
      brand: 'Peter England',
      category: 'Man',
      price: 40,
      image: AssetRes.productPeterEngland,
      gallery: [AssetRes.productPeterEngland],
      description: productDescription,
      colors: ['#FFFFFF', '#121818'],
      sizes: ['M', 'L', 'XL'],
      isFavorite: false,
      filter: StringConst.filterMan,
    ),
    ProductModel(
      id: 'p_lymio',
      brand: 'Lymio',
      category: 'Woman',
      price: 40,
      image: AssetRes.productLymio,
      gallery: [AssetRes.productLymio],
      description: productDescription,
      colors: ['#808080', '#121818'],
      sizes: ['S', 'M', 'L', 'XL'],
      isFavorite: true,
      filter: StringConst.filterPopular,
    ),
  ];

  static List<ProductModel> get wishlistProducts =>
      products.where((product) => product.isFavorite).toList();

  static ProductModel? productById(String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    return null;
  }
}
