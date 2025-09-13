import 'package:fin_assist/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editProfile),
      ),
    );
  }
}
