import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/styles/brand_color.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          // backgroundColor: BrandColors.primary,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
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
                    const Text("Password"),
                    const SizedBox(height: 6),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your password",
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    const SizedBox(height: 120),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: InkWell(
                        onTap: () => model.gotoSignUp(),
                        child: const Text.rich(
                          TextSpan(
                            text: "Don't have an account yet? ",
                            children: <TextSpan>[
                              TextSpan(text: "Sign up", style: TextStyle(color: BrandColors.primary))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 300,
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
                            "Login",
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
            ],
          ),
        );
      },
    );
  }
}
