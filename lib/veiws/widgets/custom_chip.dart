import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onSelect;
  const CustomChip({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: ChoiceChip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        label: Text(text),
        selected: isSelected,
        selectedColor: Theme.of(context).cardColor.withAlpha(20),
        backgroundColor: Theme.of(context).cardColor,
        labelStyle:
            isSelected
                ? Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)
                : Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
