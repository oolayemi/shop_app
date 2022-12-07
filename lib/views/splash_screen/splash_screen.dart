import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/styles/brand_color.dart';
import 'package:shop_app/views/splash_screen/splash_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onModelReady: (model) => model.setup(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: BrandColors.primary,
          body: Center(
            child: SizedBox(
              height: 160,
              width: 160,
              child: SvgPicture.asset("assets/logos/logo.svg"),
            ),
          ),
        );
      }
    );
  }
}
