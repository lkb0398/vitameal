import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    super.key,
    this.title,
    this.subtitle,
    this.action,
    required this.child,
  });

  final String? title;
  final String? subtitle;
  final Widget? action;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  title == null
                      ? SizedBox.shrink()
                      : Text(title!, style: TextStyle(fontSize: 18)),
                  subtitle == null
                      ? SizedBox.shrink()
                      : Text(
                          subtitle!,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                ],
              ),
              action == null ? SizedBox.shrink() : action!,
            ],
          ),
          child,
        ],
      ),
    );
  }
}
