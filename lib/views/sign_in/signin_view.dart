import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/styles/brand_color.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'signin_viewmodel.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(top: 270),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Text("Email Address"),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: model.emailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter your email",
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                        validator: (String? value) => value!.isEmpty ? "Email field cannot be empty" : null,
                      ),
                      const SizedBox(height: 30),
                      const Text("Password"),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: model.passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter your password",
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                        validator: (String? value) => value!.isEmpty ? "Password field cannot be empty" : null,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .12),
                      SquareButton(
                        title: "Login",
                        onPressed: () {
                          if(model.formKey.currentState!.validate()) {
                            // NavigationService().clearStackAndShowView(const CheckInView());
                            model.signIn(context);
                          }
                        }
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: InkWell(
                          onTap: () => model.gotoSignUp(),
                          child: const Text.rich(
                            TextSpan(
                              text: "Don't have an account yet? ",
                              children: <TextSpan>[TextSpan(text: "Sign up", style: TextStyle(color: BrandColors.primary))],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
