import 'package:flutter/material.dart';

class ColorSelectBox extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  final String iconPath;

  const ColorSelectBox({
    Key? key,
    required this.color,
    required this.selected,
    required this.onTap,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: selected ? Border.all(color: Colors.black.withOpacity(0.5), width: 3) : null,
        ),
        child: Image.asset(iconPath, width: 30, height: 30),
      ),
    );
  }
}