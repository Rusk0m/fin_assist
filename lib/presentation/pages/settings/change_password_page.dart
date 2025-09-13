import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/di.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).changePassword)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Expanded(
          child: Column(
            children: [
              SizedBox(height: 40),
              /* _customTextField(
                newPasswordController: oldPasswordController,
                suffixIcon: Icons.remove_red_eye_outlined,
                label: 'Current Password',
                isPassword: true,
              ),
              SizedBox(height: 24),*/
              _customTextField(
                newPasswordController: newPasswordController,
                suffixIcon: Icons.remove_red_eye_outlined,
                label: 'New Password',
                isPassword: true,
              ),
              SizedBox(height: 24),
              _customTextField(
                newPasswordController: confirmPasswordController,
                label: 'Confirm New Password',
                isPassword: true,
              ),
              Spacer(),
              _updatePasswordButton(
                context,
                newPasswordController,
                confirmPasswordController,
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _updatePasswordButton(
  BuildContext context,
  TextEditingController newPasswordController,
  TextEditingController confirmPasswordController,
) {
  return TextButton(
    onPressed: () async {
      try {
        if (confirmPasswordController.text == newPasswordController.text) {
          await getIt<FirebaseAuth>().currentUser!.updatePassword(
            confirmPasswordController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).passwordUpdated)),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Passwords do not match")));
          return;
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).errorUpdatingPassword)),
        );
      }
    },
    style: TextButton.styleFrom(
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
    ),
    child: Text('Change Password'),
  );
}

class _customTextField extends StatefulWidget {
  const _customTextField({
    super.key,
    required this.newPasswordController,
    this.suffixIcon,
    required this.label,
    required this.isPassword,
  });

  final TextEditingController newPasswordController;
  final IconData? suffixIcon;
  final String label;
  final bool isPassword;

  @override
  State<_customTextField> createState() => _customTextFieldState();
}

class _customTextFieldState extends State<_customTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.newPasswordController,
      decoration: InputDecoration(
        label: Text(widget.label),
        suffixIcon: GestureDetector(
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
        ),
        errorText:
            widget.newPasswordController.text.length < 6 &&
                widget.newPasswordController.text.isNotEmpty
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
