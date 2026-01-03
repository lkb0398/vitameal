import 'package:flutter/material.dart';
import 'package:vitameal/presentation/intro/model/intro_content.dart';

class IntroItem extends StatelessWidget {
  final IntroContent item;

  const IntroItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset(item.image, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}
