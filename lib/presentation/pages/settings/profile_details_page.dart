import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/presentation/pages/widgets/custom_text_field.dart';
import 'package:fin_assist/presentation/pages/widgets/toggle_button.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 24,),
            CircleAvatar(
              radius: 64,
            ),
            SizedBox(height: 16,),
            CustomTextField(textEditingController: nameController, label: S.of(context).enterNewName, isPassword: false,prefixIcon: Icons.person,),
            SizedBox(height: 16,),
            CustomTextField(textEditingController: emailController, label: S.of(context).enterNewEmail, isPassword: false,prefixIcon: Icons.alternate_email,),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).switchLocales),
                LanguageToggle(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
