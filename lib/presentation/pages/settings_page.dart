import 'package:fin_assist/generated/l10n.dart';
import 'package:fin_assist/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print('SettingsPage: State changed to $state');
        if (state is AuthUnauthenticated) {
          print('SettingsPage: Navigating to /login_page');
          Navigator.pushNamedAndRemoveUntil(context, '/login_page', (Route<dynamic> route) => false);
        } else if (state is AuthError) {
          print('SettingsPage: Auth error: ${state.message}');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settingsTitleAppBar),
          actions: [
            IconButton(
              onPressed: () {
                print('DashboardView: Logout button pressed');
                context.read<AuthBloc>().add(LogoutEvent());
              },
              icon: Icon(Icons.logout),
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
                  margin: EdgeInsetsGeometry.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  height: 160,
                  width: 120,
                  color: Colors.blueAccent,
                  child: Center(child: Text('Фото или заглушка')),
                ),
                //SizedBox(width: 50,),
                Text('Имя'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.of(context).otherSettings),
            ),
            Card(
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  SettingsRowButton(
                    iconData: Icons.person,
                    titleButton: S.of(context).profileDetails,
                  ),
                  Divider(),
                  SettingsRowButton(
                    iconData: Icons.password_outlined,
                    titleButton: S.of(context).password,
                  ),
                  Divider(),
                  SettingsRowButton(
                    iconData: Icons.notifications_active_outlined,
                    titleButton: S.of(context).notifications,
                  ),
                  Divider(),
                  SettingsRowButton(
                    iconData: Icons.nightlight_round_outlined,
                    titleButton: S.of(context).darkMode,
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
            SizedBox(height: 40),
            Card(
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  SettingsRowButton(
                    iconData: Icons.help_center_outlined,
                    titleButton: S.of(context).aboutApplication,
                  ),
                  Divider(),
                  SettingsRowButton(
                    iconData: Icons.message,
                    titleButton: S.of(context).helpfaq,
                  ),
                  Divider(),
                  SettingsRowButton(
                    iconData: Icons.delete,
                    titleButton: S.of(context).deactivateMyAccount,
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsRowButton extends StatelessWidget {
  final IconData iconData;
  final String titleButton;
  final bool? onSwitch;

  const SettingsRowButton({
    super.key,
    required this.iconData,
    required this.titleButton,
    this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(iconData)),
            Text(titleButton),
          ],
        ),
        if (onSwitch == null) ...{
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        } else ...{
          /*Switch(
            value: (ThemeState.isDark),
            onChanged: ,
          )*/
        },
      ],
    );
  }
}
