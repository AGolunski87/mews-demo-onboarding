import 'package:flutter/material.dart';

class FeatureChips extends StatelessWidget {
  final List<String> features;
  final Set<String> selected;
  final Function(String) onSelected;

  const FeatureChips({
    super.key,
    required this.features,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: features.map((feature) {
        return FilterChip(
          label: Text(feature),
          selected: selected.contains(feature),
          onSelected: (_) => onSelected(feature),
        );
      }).toList(),
    );
  }
}
