import 'package:flutter/material.dart';

class SelectBox extends StatelessWidget {
  const SelectBox({
    super.key,
    required this.onTap,
    required this.changeThisColor,
    required this.text,
    this.height,
  });

  final void Function() onTap;
  final bool changeThisColor;
  final String text;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: changeThisColor ? Colors.grey : Colors.transparent,
        ),
        height: height,
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}
