import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/constants/icon_asset_url.dart';
import 'package:navigation_2/core/theme/app_text_styles.dart';

class MySplashPage extends StatefulWidget {
  const MySplashPage({super.key});

  @override
  State<MySplashPage> createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      // load data -> check đăng nhập => login + signup
      context.go("/home");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppIconUrl.iconAppPng, width: 40),
                SvgPicture.asset(AppIconUrl.iconApp),
              ],
            ),
            Text("Splash screen", style: AppTextStyles.h1_bold),
          ],
        ),
      ),
    );
  }
}
