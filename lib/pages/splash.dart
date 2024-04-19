import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/utils/values/colors.dart';
import 'package:weather_app/utils/values/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final CustomTheme theme = CustomTheme();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      GoRouter.of(context).pushNamed(
        AppRoutes.nav,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blue,
        body: Center(
          child: Text(
            GlobalConfiguration().getValue<String>('appName'),
            style: theme.getPrimaryText.copyWith(fontSize: 40),
          ),
        ));
  }
}
