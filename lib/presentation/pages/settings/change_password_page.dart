import 'package:fin_assist/di.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/presentation/pages/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              CustomTextField(
                textEditingController: newPasswordController,
                suffixIcon: Icons.remove_red_eye_outlined,
                label: 'New Password',
                isPassword: true,
              ),
              SizedBox(height: 24),
              CustomTextField(
                textEditingController: confirmPasswordController,
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
