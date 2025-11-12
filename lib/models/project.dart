import 'package:flutter/material.dart';

/// Represents a single technology used in a project (icon & label).
class TechStackItem {
  final String label;
  final String assetPath; // SVG asset path
  final Color? color; // optional override tint if needed

  const TechStackItem({
    required this.label,
    required this.assetPath,
    this.color,
  });
}

class Project {
  final String title;
  final String description;
  final String imagePath;
  final String? liveUrl;
  final String? sourceCodeUrl;
  final List<TechStackItem> techStack;
  // Optional per-project fixed card height (desktop); if null, height adapts to content.
  final double? cardHeight;
  // If true, the project image will have a white background
  final bool hasWhiteBackground;
  // If true, an NDA badge will be shown instead of action buttons
  final bool showNdaBadge;

  const Project({
    required this.title,
    required this.description,
    required this.imagePath,
    this.liveUrl,
    this.sourceCodeUrl,
    this.techStack = const [],
    this.cardHeight,
    this.hasWhiteBackground = false,
    this.showNdaBadge = false,
  });
}
