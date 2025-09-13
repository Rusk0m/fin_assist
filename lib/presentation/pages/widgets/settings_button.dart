import 'package:flutter/material.dart';

class SettingsRowButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool? value;
  final ValueChanged<bool>? onChanged; // для переключателя
  final VoidCallback? onTap; // для кнопки-навигации

  const SettingsRowButton({
    super.key,
    required this.iconData,
    required this.title,
    this.value,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(child: Icon(iconData)),
                const SizedBox(width: 10),
                Text(title),
              ],
            ),
            if (value == null) ...{
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
            } else ...{
              Switch(value: value!, onChanged: onChanged),
            },
          ],
        ),
      ),
    );
  }
}