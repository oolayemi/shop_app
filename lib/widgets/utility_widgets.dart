import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/core/models/store_products_response.dart';

import '../core/models/nearby_store.dart';
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
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch as Map<int, Color>);
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

class SomethingSha extends StatefulWidget {
  final dynamic model;
  final int? index;

  const SomethingSha({Key? key, this.model, this.index}) : super(key: key);

  @override
  State<SomethingSha> createState() => _SomethingShaState();
}

class _SomethingShaState extends State<SomethingSha> {
  Product? selectedProduct;
  int? quantity;

  @override
  void initState() {
    print(widget.index);
    super.initState();
  }

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
                  onTap: () => buildDropDown(
                      ctx: context,
                      check: widget.model.storeProducts,
                      onSelectProduct: (product) {
                        selectedProduct = product;
                        if (quantity != null) {
                          widget.model.setValueInProducts(widget.index, selectedProduct, quantity);
                        }
                        setState(() {});
                      }),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          selectedProduct?.name ?? "Select product",
                          overflow: TextOverflow.ellipsis,
                        )),
                        const Icon(Icons.keyboard_arrow_down_rounded)
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
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    initialValue: widget.index.toString(),
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
                    validator: (string) => string!.isEmpty ? "Set value" : null,
                    onChanged: (String value) {
                      quantity = value.isEmpty ? 0 : int.parse(value);
                      if (selectedProduct != null) {
                        widget.model.setValueInProducts(widget.index, selectedProduct, quantity);
                      }
                    },
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

void buildDropDown({required BuildContext ctx, required List<StoreProductData>? check, Function(Product)? onSelectProduct}) {
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
                  for (StoreProductData item in check!)
                    InkWell(
                      onTap: () {
                        onSelectProduct != null ? onSelectProduct(item.product!) : null;
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
                                item.product!.name!,
                                style: Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize: SizeConfig.textSize(context, 2),
                                    ),
                              ),
                            ),
                            Text(
                              "₦${item.product!.price}",
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

void buildStoreDropDown({required BuildContext ctx, List<Store>? check, Function(Store)? selectStore}) {
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
                        for (Store item in check!)
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
                                        item.name!,
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
