import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/utility_widgets.dart';
import 'set_password_viewmodel.dart';


class SetPasswordView extends StatelessWidget {
  const SetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetPasswordViewModel>.reactive(
      viewModelBuilder: () => SetPasswordViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          // backgroundColor: BrandColors.primary,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 280,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/top_auth.png"), fit: BoxFit.fill),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/logos/logo.svg", height: 70),
                          const SizedBox(height: 15),
                          const Text(
                            "Set Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(
                            width: 250,
                            child: Text(
                              "To Create an Account, you have to sign in with your valid credentials.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/bottom_auth.png"), fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(top: 270),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email Address"),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your email",
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text("Phone Number"),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your phone number",
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .12),
                    SquareButton(title: 'Confirm', onPressed: () => model.gotoCheckOut()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
