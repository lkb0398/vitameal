import 'dart:io';
import 'package:flutter/material.dart';

class RecipeStepUIModel {
  File? image;
  String? existingImageUrl;
  final TextEditingController controller;

  RecipeStepUIModel({
    this.image,
    this.existingImageUrl,
    required this.controller,
  });

  Map<String, dynamic> toDataMap(int order, String? uploadedImageUrl) {
    return {
      'step_order': order,
      'description': controller.text,
      'image_url': uploadedImageUrl ?? existingImageUrl,
    };
  }
}
