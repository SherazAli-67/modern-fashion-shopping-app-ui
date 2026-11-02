import 'package:flutter/material.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';

class FilterChipRow extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FilterChipRow({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: NumberConstant.chipSpacing,
        children: [
          for (var i = 0; i < labels.length; i++)
            GestureDetector(
              onTap: () => onSelected(i),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: i == selectedIndex ? AppColors.accent : AppColors.chipBg,
                  borderRadius: .circular(NumberConstant.pillRadius),
                  border: .all(color: AppColors.whiteBorder),
                ),
                child: Padding(
                  padding: .symmetric(horizontal: NumberConstant.chipHorizontalPadding, vertical: NumberConstant.chipVerticalPadding),
                  child: Text(labels[i].toUpperCase(), style: AppTextStyles.chipLabel,),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
