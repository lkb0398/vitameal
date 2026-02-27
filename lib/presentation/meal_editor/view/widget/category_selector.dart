import 'package:flutter/material.dart';
import 'package:vitameal/core/config/l10n/l10n.dart';
import 'package:vitameal/core/theme/app_theme.dart';
import 'package:vitameal/domain/enum/meal_category_enum.dart';

class CategorySelector extends StatelessWidget {
  /// 카테고리 선택
  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final MealCategory selectedCategory;
  final ValueChanged<MealCategory> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context)!; // 🌎

    final categoryMap = {
      l.breakfast: MealCategory.breakfast,
      l.lunch: MealCategory.lunch,
      l.dinner: MealCategory.dinner,
      l.snack: MealCategory.snack,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.category,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: vrc(context).text,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: categoryMap.entries
              .map(
                (entry) => _CategoryChip(
                  label: entry.key,
                  selected: selectedCategory == entry.value,
                  onTap: () => onCategoryChanged(entry.value),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? vrc(context).greyBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? vrc(context).hint! : vrc(context).border!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            color: vrc(context).text,
          ),
        ),
      ),
    );
  }
}
