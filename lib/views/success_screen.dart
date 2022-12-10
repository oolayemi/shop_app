import 'package:flutter/material.dart';
import 'package:shop_app/widgets/utility_widgets.dart';

class SuccessfulScreen extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final Function()? onPressed;

  const SuccessfulScreen({Key? key, required this.title, required this.buttonTitle, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/check_sign.png"),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Color(0xFF102002)),
                  )
                ],
              ),
            ),
          ),
          SquareButton(
            title: buttonTitle,
            onPressed: onPressed ?? () => Navigator.pop(context),
          ),
          const Expanded(child: SizedBox())
        ],
      ),
    );
  }
}
