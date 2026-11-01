import 'package:flutter/material.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text(StringConst.wishlistTitle),),);
  }
}
