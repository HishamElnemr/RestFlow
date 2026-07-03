import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;
  final LinearGradient gradient;

  const OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.gradient,
  });
}
