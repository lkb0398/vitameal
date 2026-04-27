import 'package:flutter/material.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    super.key,
    required this.onTap,
    required this.title,
    this.subtitle,
    required this.child,
  });

  final VoidCallback onTap;
  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final f = fxc(context);
    final v = vrc(context);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: v.infoContainer,
        boxShadow: [
          BoxShadow(color: v.infoShadow!, blurRadius: 10, offset: Offset(0, 0)),
        ],
      ),
      child: Column(
        spacing: 10,
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsetsGeometry.only(left: 10),
                    child: Text(
                      subtitle!,
                      style: TextStyle(fontSize: 12, color: f.textcolor300),
                    ),
                  ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
