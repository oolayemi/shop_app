import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../core/models/product_data.dart';
import '../core/utils/size_config.dart';
import '../styles/brand_color.dart';

flusher(String? message, BuildContext context, {int sec = 3, Color? color, String? title}) {
  return Flushbar(
    backgroundColor: color ?? BrandColors.primary,
    duration: Duration(seconds: sec),
    title: title,
    message: message,
    icon: const Icon(Icons.info_outline, size: 28.0, color: Colors.white),
    leftBarIndicatorColor: Colors.black,
  ).show(context);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch as Map<int, Color>);
}

Widget customTextField(
    {String? label,
    String? hintText,
    String? prefixImage,
    String? suffixImage,
    int? minLines,
    int? maxLines,
    TextEditingController? controller,
    bool? obscure,
    TextInputAction? action,
    TextInputType? inputType,
    Function? onChanged,
    Function? suffixFunc,
    String? errorText,
    bool? enabled,
    String? helperText,
    TextStyle? helperStyle,
    int? maxLength,
    List<String>? hints,
    required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      label == null
          ? const SizedBox()
          : Container(
              margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, .5)),
              child: Text(
                label,
                style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: SizeConfig.textSize(context, 1.8)),
              ),
            ),
      Row(
        children: [
          Expanded(
            child: TextField(
              autofillHints: hints,
              enableInteractiveSelection: true,
              enabled: enabled ?? true,
              controller: controller,
              maxLines: maxLines ?? 1,
              minLines: minLines,
              obscureText: obscure ?? false,
              style: TextStyle(
                fontSize: SizeConfig.textSize(context, 2),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: inputType ?? TextInputType.text,
              onChanged: onChanged as void Function(String)?,
              maxLength: maxLength,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                hintText: hintText ?? '',
                hintStyle: TextStyle(fontSize: SizeConfig.textSize(context, 2)),
                helperText: helperText,
                helperStyle: helperStyle,
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: BorderSide(color: BrandColors.outlineText, width: 0.0),
                ),
                border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1))),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1))),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BrandColors.secondary),
                    borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1))),
                errorText: errorText,
                contentPadding:
                    EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 4)),
                prefixIcon: prefixImage == null
                    ? null
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(prefixImage),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          suffixImage == null
              ? const SizedBox()
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 1)),
                  child: InkWell(
                    enableFeedback: true,
                    // excludeFromSemantics: true,
                    borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1)),

                    onTap: suffixFunc as void Function()?,
                    child: Container(
                      height: SizeConfig.yMargin(context, 6),
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.yMargin(context, 0.5), horizontal: SizeConfig.xMargin(context, 3.8)),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: BrandColors.outlineText,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.yMargin(context, 1),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            suffixImage,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    ],
  );
}

Widget customDropdown<T>(
    {String? label, T? value, List<DropdownMenuItem<T>>? items, Function? onChanged, required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      label == null
          ? const SizedBox()
          : Container(
              margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, .5)),
              child: Text(
                label,
                style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: SizeConfig.textSize(context, 2)),
              ),
            ),
      Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2.2), horizontal: SizeConfig.xMargin(context, 4)),
        decoration: BoxDecoration(
            color: const Color(0xFFB9B9B9).withOpacity(0.12), borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1))),
        child: DropdownButton(
            // focusColor: Color(0xFFB9B9B9).withOpacity(0.12),
            dropdownColor: Colors.white,
            elevation: 0,
            underline: const SizedBox(),
            isDense: true,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: BrandColors.secondary,
            ),
            value: value,
            items: items,
            onChanged: onChanged!()),
      ),
    ],
  );
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool withBackButton;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, this.title, this.withBackButton = true, this.actions}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      leading: withBackButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 32,
                color: Colors.black,
              ),
            )
          : null,
      actions: actions,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(color: Colors.black),
            )
          : const SizedBox(),
    );
  }
}

class CustomScaffoldWidget extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final double padding;

  const CustomScaffoldWidget({Key? key, this.appBar, required this.body, this.padding = 15.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.mainBackground,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: body,
      ),
    );
  }
}

class SomethingSha extends StatelessWidget {
  const SomethingSha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Product",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () => buildDropDown(ctx: context, check: [
                    ProductData('Eva Water', '3,000'),
                    ProductData('Aqua Water', '12,000'),
                    ProductData('Red Wine', '35,000'),
                    ProductData('Little Liquor', '10,000'),
                    ProductData('Eva Water with lime sauce and ginger flavour', '30,000'),
                  ]),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                            child: Text(
                          "Select product",
                          overflow: TextOverflow.ellipsis,
                        )),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * .33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quantity",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                InkWell(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Quantity",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.black, width: 1.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.black, width: 1.2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.black, width: 1.2)),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void buildDropDown({required BuildContext ctx, required List<ProductData> check, Function? selectPlan}) {
  showModalBottomSheet(
    enableDrag: false,
    context: ctx,
    isDismissible: false,
    backgroundColor: BrandColors.mainBackground,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topRight: Radius.circular(SizeConfig.yMargin(ctx, 3)),
      topLeft: Radius.circular(SizeConfig.yMargin(ctx, 3)),
    )),
    builder: (context) => Container(
      padding: EdgeInsets.only(top: SizeConfig.yMargin(context, 2)),
      height: SizeConfig.yMargin(context, 70),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Product'),
                IconButton(onPressed: () => Navigator.of(ctx).pop(), icon: const Icon(Icons.close))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Search Products',
                  prefixIcon: Icon(Icons.search_sharp),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8)),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                // if (value.isNotEmpty) {
                //   final suggestions = banks!.where((bank) {
                //     final bankName =
                //     bank.bankName.toString().toLowerCase();
                //     final input = value.toLowerCase();
                //
                //     return bankName.contains(input);
                //   }).toList();
                //
                //   // allBanks = suggestions;
                //
                //   setStater(() {
                //     allBanks = suggestions;
                //   });
                // }
              },
              style: const TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (ProductData item in check)
                    InkWell(
                      onTap: () {
                        selectPlan != null ? selectPlan(item) : null;
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        width: SizeConfig.xMargin(context, 100),
                        padding:
                            EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 4)),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.xMargin(context, 2)),
                              width: MediaQuery.of(context).size.width * .65,
                              child: Text(
                                item.name,
                                style: Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize: SizeConfig.textSize(context, 2),
                                    ),
                              ),
                            ),
                            Text(
                              "₦${item.amount}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

void buildStoreDropDown({required BuildContext ctx, check, Function? selectStore}) {
  showModalBottomSheet(
      enableDrag: false,
      context: ctx,
      isDismissible: false,
      backgroundColor: BrandColors.mainBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(SizeConfig.yMargin(ctx, 3)),
        topLeft: Radius.circular(SizeConfig.yMargin(ctx, 3)),
      )),
      builder: (context) => Container(
            padding: EdgeInsets.only(top: SizeConfig.yMargin(context, 2)),
            height: SizeConfig.yMargin(context, 70),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select Store'),
                      IconButton(onPressed: () => Navigator.of(ctx).pop(), icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (String item in check)
                          InkWell(
                            onTap: () {
                              selectStore != null ? selectStore(item) : null;
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              width: SizeConfig.xMargin(context, 100),
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 4)),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: SizeConfig.xMargin(context, 2)),
                                      child: Text(
                                        item,
                                        style:
                                            Theme.of(context).textTheme.headline3!.copyWith(fontSize: SizeConfig.textSize(context, 2)),
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
}

class SquareButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const SquareButton({Key? key, required this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BrandColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 20),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
        ),
        child: Text(title),
      ),
    );
  }
}
