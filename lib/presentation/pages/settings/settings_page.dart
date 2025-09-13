import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:fin_assist/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:fin_assist/presentation/pages/widgets/settings_button.dart';
import 'package:fin_assist/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading || state is UserInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is UserLoaded) {
          return SettingsView(user: state.user);
        } else if (state is UserError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}


class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.user});

  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;
    final sendNotification = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settingsTitleAppBar),
        actions: [
          IconButton(
            onPressed: () {
              print('SettingsPage: Logout button pressed');
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                height: 160,
                width: 120,
                color: Colors.blueAccent,
                child: const Center(child: Text('Фото или заглушка')),
              ),
              Text(user.name!),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(S.of(context).otherSettings),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1.5, color: Colors.white24),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                SettingsRowButton(
                  iconData: Icons.person,
                  title: S.of(context).profileDetails,
                  onTap: () =>
                      Navigator.pushNamed(context, '/profile_details_page'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                SettingsRowButton(
                  iconData: Icons.password_outlined,
                  title: S.of(context).password,
                  onTap: () =>
                      Navigator.pushNamed(context, '/change_password_page'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                SettingsRowButton(
                  iconData: Icons.notifications_active_outlined,
                  title: S.of(context).notifications,
                  value: sendNotification,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                SettingsRowButton(
                  iconData: Icons.nightlight_round_outlined,
                  title: S.of(context).darkMode,
                  value: isDarkTheme,
                  onChanged: (value) {
                    _setThemeBrightness(context, value);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1.5, color: Colors.white24),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                SettingsRowButton(
                  iconData: Icons.help_center_outlined,
                  title: S.of(context).aboutApplication,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                SettingsRowButton(
                  iconData: Icons.message,
                  title: S.of(context).helpfaq,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                SettingsRowButton(
                  iconData: Icons.delete,
                  title: S.of(context).deactivateMyAccount,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _setThemeBrightness(BuildContext context, bool value) {
  context.read<ThemeCubit>().setThemeBrightness(
    value ? Brightness.dark : Brightness.light,
  );
}
