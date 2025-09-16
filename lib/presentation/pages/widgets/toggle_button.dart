import 'package:fin_assist/locale/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return ToggleButtons(
      isSelected: [locale.languageCode == 'en', locale.languageCode == 'ru'],
      onPressed: (index) {
        print(index);
        index == 0
            ? context.read<LocaleCubit>().setLocale(const Locale('en'))
            : context.read<LocaleCubit>().setLocale(const Locale('ru'));
      },
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('EN'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('RU'),
        ),
      ],
    );
  }
}
