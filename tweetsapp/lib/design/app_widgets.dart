import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tweetsapp/design/app_images.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 40,
        child: SvgPicture.asset(
          AppImages.logo,
          color: Colors.white,
        ));
  }
}
