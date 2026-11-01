import 'package:flutter/material.dart';
import 'package:modern_shopping_app_ui/core/app_data.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = AppData.productById(productId);
    return Scaffold(body: Center(child: Text(product?.brand ?? productId),),);
  }
}
