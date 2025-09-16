import 'package:fin_assist/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    this.suffixIcon,
    required this.label,
    required this.isPassword,
    this.prefixIcon,
  });

  final TextEditingController textEditingController;
  final IconData? suffixIcon;
  final String label;
  final bool isPassword;
  final IconData? prefixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        label: Text(widget.label),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                ),
              )
            : null,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        errorText:
            widget.textEditingController.text.length < 6 &&
                widget.textEditingController.text.isNotEmpty
            ? S.of(context).invalidPassword
            : null,
      ),
      obscureText: _obscureText,
      enableSuggestions: !widget.isPassword,
      autocorrect: !widget.isPassword,
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
