import 'package:flutter/material.dart';
import 'package:shop_app/views/check_in/check_in_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../styles/brand_color.dart';

class CheckInView extends StatelessWidget {
  const CheckInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckInViewModel>.reactive(
      viewModelBuilder: () => CheckInViewModel(),
      onModelReady: (model) => model.setUp(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: BrandColors.primaryBg,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: const Text(
                    "Ensure you check in and take stock before you begin your day",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    model.gotoCheckInForm(context);
                  },
                  child: Image.asset(
                    "assets/images/check_in.png",
                    height: 180,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
